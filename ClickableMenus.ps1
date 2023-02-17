<#
	.LINK
	https://github.com/jantari/ClickableMenus
#>

#Requires -Version 5.0

$consoleAPI = @"
using System;
using System.Runtime.InteropServices;

public class ConsoleAPI
{
    [StructLayout(LayoutKind.Sequential)]
    public struct COORD
    {
        public short X;
        public short Y;
    }

    [Flags]
    public enum ConsoleOutputModes : uint
    {
        ENABLE_PROCESSED_OUTPUT            = 0x0001,
        ENABLE_WRAP_AT_EOL_OUTPUT          = 0x0002,
        ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004,
        DISABLE_NEWLINE_AUTO_RETURN        = 0x0008,
        ENABLE_LVB_GRID_WORLDWIDE          = 0x0010,
    }

    public enum ControlKeyState {
        // /* dwControlKeyState bitmask */
        RIGHT_ALT_PRESSED = 1,
        LEFT_ALT_PRESSED = 2,
        RIGHT_CTRL_PRESSED = 4,
        LEFT_CTRL_PRESSED = 8,
        SHIFT_PRESSED = 16,
        NUMLOCK_ON = 32,
        SCROLLLOCK_ON = 64,
        CAPSLOCK_ON = 128,
        ENHANCED_KEY = 256,
    }

    [StructLayout(LayoutKind.Explicit)]
    public struct INPUT_RECORD
    {
        [FieldOffset(0)]
        public short EventType;
        //union {
        [FieldOffset(4)]
        public KEY_EVENT_RECORD KeyEvent;
        [FieldOffset(4)]
        public MOUSE_EVENT_RECORD MouseEvent;
        [FieldOffset(4)]
        public WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
        [FieldOffset(4)]
        public MENU_EVENT_RECORD MenuEvent;
        [FieldOffset(4)]
        public FOCUS_EVENT_RECORD FocusEvent;
    }
    
    [StructLayout(LayoutKind.Sequential)]
    public struct KEY_EVENT_RECORD
    {
        public uint bKeyDown;
        public short wRepeatCount;
        public short wVirtualKeyCode;
        public short wVirtualScanCode;
        public char UnicodeChar;
        public int dwControlKeyState;
    }
    
    [StructLayout(LayoutKind.Sequential)]
    public struct MOUSE_EVENT_RECORD
    {
        public COORD dwMousePosition;
        public int dwButtonState;
        public int dwControlKeyState;
        public int dwEventFlags;
    };
    
    [StructLayout(LayoutKind.Sequential)]
    public struct WINDOW_BUFFER_SIZE_RECORD
    {
        public COORD dwSize;
    }
    
    [StructLayout(LayoutKind.Sequential)]
    public struct MENU_EVENT_RECORD
    {
        public int dwCommandId;
    }
    
    [StructLayout(LayoutKind.Sequential)]
    public struct FOCUS_EVENT_RECORD
    {
        public uint bSetFocus;
    }

    public static int STD_OUTPUT_HANDLE = -11;
    public static int STD_INPUT_HANDLE  = -10;

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern int GetLastError();

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr GetStdHandle(int nStdHandle);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool PeekConsoleInput(IntPtr hConsoleInput, ref INPUT_RECORD lpBuffer, uint nLength, ref uint lpNumberOfEventsRead);
    
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool ReadConsoleInput(IntPtr hConsoleInput, ref INPUT_RECORD lpBuffer, uint nLength, ref uint lpNumberOfEventsRead);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
}
"@

Add-Type $consoleAPI

[char]$ESC = 0x1b
[bool]$QUIT_FORM = $false

[uint32]$UIElementIDAutoAssign = 0
$UIElementIDsInUse = [System.Collections.Generic.List[uint32]]::new()

$hIn = [ConsoleAPI]::GetStdHandle( [ConsoleAPI]::STD_INPUT_HANDLE )

class UIForm {
    [uint32]$ID
    [string]$Name
    [int[]]$X
    [int[]]$Y
    [bool]$Border
    [bool]$ClearScreen
    [System.Collections.Generic.List[UIElement]]$Elements = [System.Collections.Generic.List[UIElement]]::new()

    Add ([UIElement[]]$Element) {
        foreach ($e in $Element) {
            $this.Elements.Add($e)
        }
    }

    Remove ([UIElement]$Element) {
        foreach ($e in $Element) {
            $this.Elements.Remove($e)
        }
    }

    [Object] Show () {
        if ($this.ClearScreen) {
            [console]::Clear()
        }

        $absoluteYcoords = Get-AbsoluteYCoordinates -Y $this.Y

        [console]::SetCursorPosition($this.X[0], $absoluteYcoords[0])
        if ($this.Border -or (-not $this.ClearScreen)) {
            # Top edge
            Write-Host "$script:ESC(0l$('q' * ($this.X[-1] - $this.X[0] - 1))k$script:ESC(B"
            # Sides
            for ($i = $absoluteYcoords[1]; $i -lt $absoluteYcoords[-1]; $i++) {
                if ($this.ClearScreen) {
                    [console]::SetCursorPosition($this.X[0], $i)
                    Write-Host "$script:ESC(0x$script:ESC(B"
                    [console]::SetCursorPosition($this.X[-1], $i)
                    Write-Host "$script:ESC(0x$script:ESC(B"
                }
                else {
                    [console]::SetCursorPosition($this.X[0], $i)
                    Write-Host "$script:ESC(0x$(' ' * ($this.X[-1] - $this.X[0] - 1))x$script:ESC(B"
                }
            }
            # Bottom edge
            [console]::SetCursorPosition($this.X[0], $absoluteYcoords[-1])
            Write-Host "$script:ESC(0m$('q' * ($this.X[-1] - $this.X[0] - 1))j$script:ESC(B" -NoNewline
        }
        foreach ($UIElement in $this.Elements) {
            switch ($UIElement.GetType().Name) {
                'UIButton' {
                    Show-UIButton -Button $UIElement
                }
                'UICheckbox' {
                    Show-UICheckBox -Checkbox $UIElement
                }
                'UILabel' {
                    Show-UILabel -Label $UIElement
                }
            }
        }
        #[console]::SetCursorPosition($this.X[0], $absoluteYcoords[0])
        return Wait-UIClick -UIElements $this.Elements
    }
}

class UIElement {
    [uint32]$ID
    [string]$Text
    [int]$TextPadding
    [int[]]$X
    [int[]]$Y
}

class UIButton : UIElement {
    [string]$HLStyle
    [bool]$QuitsForm = $false
    [scriptblock]$ClickScript
    [Object] Click([System.Object[]] $args) {
        if ($this.QuitsForm) {
            $script:QUIT_FORM = $true
            return $this
        }
        elseif ($this.ClickScript) {
            return $this.ClickScript.Invoke($args)
        }
        else {
            return 0
        }
    }
    [Object] Click () {
        if ($this.QuitsForm) {
            $script:QUIT_FORM = $true
            return $this
        }
        elseif ($this.ClickScript) {
            return $this.ClickScript.Invoke()
        }
        else {
            return 0
        }
    }
}

class UICheckbox : UIElement {
    [string]$HLStyle
    [bool]$Checked
}

class UIComboBox : UIElement {
    [System.Collections.Generic.List[string]]$Items
}

class UILabel : UIElement {}

function New-UIForm {
    Param (
        [uint32]$ID = $script:UIElementIDAutoAssign++,
        [string]$Name,
        [ValidateScript({ $_ -in 0..([console]::WindowWidth) })]
        [int[]]$X = 0..([console]::WindowWidth - 1),
        [ValidateScript({ $_ -in 0..([console]::WindowHeight) })]
        [int[]]$Y = 0..([console]::WindowHeight - 1),
        [switch]$Border,
        [switch]$ClearScreen,
        [System.Collections.Generic.List[UIElement]]$Elements = [System.Collections.Generic.List[UIElement]]::new()
    )

    $UIElementIDsInUse.Add($ID)

    return [UIForm]@{
        'ID'          = $ID
        'Name'        = $Name
        'X'           = $X
        'Y'           = $Y
        'Border'      = $Border
        'ClearScreen' = $ClearScreen
        'Elements'    = $Elements
    }
}

function New-UIButton {
    Param (
        [ValidateScript({ $_ -notin $UIElementIDsInUse })]
        [uint32]$ID = $script:UIElementIDAutoAssign++,
        [Parameter( Mandatory = $true )]
        [string]$Text,
        [switch]$QuitsForm,
        [scriptblock]$ClickScript,
        [int]$X = $host.UI.RawUI.WindowSize.Width / 2, # Pseudo-Center by default
        [int]$Y = $host.UI.RawUI.WindowSize.Height / 2, # Center by default
        [ValidateSet('Underline', 'ColorText', 'ColorElement', 'None')]
        [string]$HighlightStyle = 'ColorElement',
        [int]$TextPadding = 4
    )

    $UIElementIDsInUse.Add($ID)
    [int]$ButtonLength = $X + $Text.Length + $TextPadding * 2 + 1

    return [UIButton]@{
        'ID'          = $ID
        'Text'        = $Text
        'QuitsForm'   = $QuitsForm
        'ClickScript' = $ClickScript
        'TextPadding' = $TextPadding
        'X'           = $X..$ButtonLength
        'Y'           = $Y..($Y + 2 )
        'HLStyle'     = $HighlightStyle
    }
}

function New-UICheckBox {
    Param (
        [ValidateScript({ $_ -notin $UIElementIDsInUse })]
        [uint32]$ID = $script:UIElementIDAutoAssign++,
        [Parameter( Mandatory = $true )]
        [string]$Text,
        [switch]$Checked,
        [ValidateSet('Underline', 'ColorText', 'ColorElement', 'None')]
        [string]$HighlightStyle = 'None',
        [int]$X = $host.UI.RawUI.WindowSize.Width / 2, # Pseudo-Center by default
        [int]$Y = $host.UI.RawUI.WindowSize.Height / 2, # Center by default
        [int]$TextPadding = 1
    )

    $UIElementIDsInUse.Add($ID)
    [int]$ElementLength = $X + $Text.Length + $TextPadding + 3

    return [UICheckbox]@{
        'ID'          = $ID
        'Text'        = $Text
        'TextPadding' = $TextPadding
        'X'           = $X..$ElementLength
        'Y'           = $Y
        'HLStyle'     = $HighlightStyle
        'Checked'     = $Checked
    }
}

function New-UILabel {
    Param (
        [ValidateScript({ $_ -notin $UIElementIDsInUse })]
        [uint32]$ID = $script:UIElementIDAutoAssign++,
        [Parameter( Mandatory = $true )]
        [string]$Text,
        [int]$X = $host.UI.RawUI.WindowSize.Width / 2, # Pseudo-Center by default
        [int]$Y = $host.UI.RawUI.WindowSize.Height / 2, # Center by default
        [int]$TextPadding = 0
    )

    $UIElementIDsInUse.Add($ID)

    return [UILabel]@{
        'ID'          = $ID
        'Text'        = $Text -replace "`n"
        'TextPadding' = $TextPadding
        'X'           = $X..($X + $Text.Length - 1)
        'Y'           = $Y
    }
}

function Show-UIButton {
    Param (
        [Parameter( ValueFromPipeline = $true )]
        [UIButton[]]$Button,
        [switch]$Highlight
    )

    process {
        $ButtonContent = "$(' ' * $Button.TextPadding)$($Button.Text)$(' ' * $Button.TextPadding)"
        $absoluteYcoord = Get-AbsoluteYCoordinates -Y $Button.Y

        if ($Highlight) {
            switch ($Button.HLStyle) {
                'Underline' {
                    [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[1])
                    Write-Host "|$(' ' * $Button.TextPadding)$ESC[4m$($Button.Text)$ESC[0m$(' ' * $Button.TextPadding)|"
                }
                'ColorElement' {
                    [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[0])
                    Write-Host "$('▄' * $Button.X.Count)"
                    [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[1])
                    Write-Host " $(' ' * $Button.TextPadding)$($Button.Text)$(' ' * $Button.TextPadding) " -ForegroundColor $Host.UI.RawUI.BackgroundColor -BackgroundColor $Host.UI.RawUI.ForegroundColor
                    [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[2])
                    Write-Host "$('▀' * $Button.X.Count)"
                }
                'ColorText' {
                    $ButtonContent = "$(' ' * $Button.TextPadding)$($Button.Text)$(' ' * $Button.TextPadding)"
                    [console]::SetCursorPosition($Button.X[1], $absoluteYcoord[1])
                    Write-Host $ButtonContent -ForegroundColor $Host.UI.RawUI.BackgroundColor -BackgroundColor $Host.UI.RawUI.ForegroundColor 
                }
                default {}
            }
        }
        else {
            [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[0])
            Write-Host "$ESC(0l$("q" * $ButtonContent.Length)k$ESC(B"
            [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[1])
            Write-Host "$ESC(0x$ESC(B$ButtonContent$ESC(0x$ESC(B"
            [console]::SetCursorPosition($Button.X[0], $absoluteYcoord[-1])
            Write-Host "$ESC(0m$("q" * $ButtonContent.Length)j$ESC(B"
        }
    }
}

function Show-UICheckBox {
    Param (
        [Parameter( ValueFromPipeline = $true )]
        [UICheckbox[]]$Checkbox,
        [switch]$Highlight
    )

    process {
        $absoluteYcoords = Get-AbsoluteYCoordinates -Y $Checkbox.Y

        if ($Highlight) {
            [console]::SetCursorPosition($Checkbox.X[0], $absoluteYcoords[0])
            # Always underline for now
            switch ($Checkbox.HLStyle) {
                'Underline' {
                    if ($Checkbox.Checked) {
                        Write-Host "$ESC[4m[X]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)$ESC[0m"
                    }
                    else {
                        Write-Host "$ESC[4m[ ]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)$ESC[0m"
                    }
                }
                'ColorElement' {
                    if ($Checkbox.Checked) {
                        Write-Host "[X]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)" -ForegroundColor $Host.UI.RawUI.BackgroundColor -BackgroundColor $Host.UI.RawUI.ForegroundColor
                    }
                    else {
                        Write-Host "[ ]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)" -ForegroundColor $Host.UI.RawUI.BackgroundColor -BackgroundColor $Host.UI.RawUI.ForegroundColor
                    }
                }
                'ColorText' {
                    [console]::SetCursorPosition($Checkbox.X[2], $absoluteYcoords[0])
                    Write-Host "$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)" -ForegroundColor $Host.UI.RawUI.BackgroundColor -BackgroundColor $Host.UI.RawUI.ForegroundColor
                }
                default {}
            }
        }
        else {
            [console]::SetCursorPosition($Checkbox.X[0], $absoluteYcoords[0])
            if ($Checkbox.Checked) {
                Write-Host "[X]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)"
            }
            else {
                Write-Host "[ ]$(' ' * $Checkbox.TextPadding)$($Checkbox.Text)"
            }
        }
    }
}

function Show-UILabel {
    Param (
        [Parameter( ValueFromPipeline = $true )]
        [UILabel[]]$Label
    )

    process {
        $absoluteYcoords = Get-AbsoluteYCoordinates -Y $Label.Y
        [console]::SetCursorPosition($Label.X[0], $absoluteYcoords[0])
        Write-Host $Label.Text
    }
}

function Get-AbsoluteYCoordinates {
    Param (
        [int[]]$Y
    )

    return $Y.ForEach({ $_ + [console]::WindowTop })
}

function Reset-UIElementIDs {
    [uint32]$script:UIElementIDAutoAssign = 0
    $script:UIElementIDsInUse = [System.Collections.Generic.List[uint32]]::new()
}

function Wait-UIClick {
    Param (
        [Parameter( ValueFromPipeline = $true )]
        [UIElement[]]$UIElements
    )

    begin {
        # Disable mouse text selection so we can grab mouse as input
        # ENABLE_MOUSE_INPUT    0x0010
        # ENABLE_EXTENDED_FLAGS 0x0080
        # ENABLE_WINDOW_INPUT   0x0008
        [uint32]$oldConMode = 0
        $formReturnValue = -1
        $null = [ConsoleAPI]::GetConsoleMode($hIn, [ref]$oldConMode)
        $null = [ConsoleAPI]::SetConsoleMode($hIn, 0x0010 -bor 0x0080 -bor 0x0008)
        [console]::CursorVisible = $false
    }

    process {
        while (-not $QUIT_FORM) {
            $lpBuffer = New-Object ConsoleAPI+INPUT_RECORD
            do {
                $null = [ConsoleAPI]::ReadConsoleInput($hIn, [ref]$lpBuffer, 1, [ref]1)
            } until (($lpBuffer.EventType -eq 2) -or
                    ($lpBuffer.EventType -eq 1 -and $lpBuffer.KeyEvent.wVirtualKeyCode -eq 0x1B))
    
            if ($lpBuffer.MouseEvent.dwEventFlags -eq 1) {
                # Mouse move event
                foreach ($UIElement in $UIElements) {
                    if (($lpBuffer.MouseEvent.dwMousePosition.X -in $UIElement.X) -and ($lpBuffer.MouseEvent.dwMousePosition.Y -in (Get-AbsoluteYCoordinates -Y $UIElement.Y))) {
                        # Mouse is over top of UIElement - highlight it
                        switch ($UIElement.GetType().Name) {
                            'UIButton' {
                                $null = Show-UIButton -Button $UIElement -Highlight
                            }
                            'UICheckbox' {
                                $null = Show-UICheckBox -Checkbox $UIElement -Highlight
                            }
                        }
                    }
                    else {
                        # Restore normal look, as mouse pointer is now off the element
                        switch ($UIElement.GetType().Name) {
                            'UIButton' {
                                $null = Show-UIButton -Button $UIElement
                            }
                            'UICheckBox' {
                                $null = Show-UICheckBox -Checkbox $UIElement
                            }
                        }
                    }
                }
            }
            elseif ($lpBuffer.MouseEvent.dwButtonState -eq 0x01) {
                # single left click event
                foreach ($UIElement in $UIElements) {
                    if (($lpBuffer.MouseEvent.dwMousePosition.X -in $UIElement.X) -and ($lpBuffer.MouseEvent.dwMousePosition.Y -in (Get-AbsoluteYCoordinates -Y $UIElement.Y))) {
                        # Mouse was over top of UIElement when click occured
                        switch ($UIElement.GetType().Name) {
                            'UIButton' {
                                $formReturnValue = $UIElement.Click()
                            }
                            'UICheckbox' {
                                $UIElement.Checked = -not $UIElement.Checked
                                $null = Show-UICheckBox -Checkbox $UIElement
                            }
                        }
                    }
                }
            }
            elseif ($lpBuffer.KeyEvent.wVirtualKeyCode -eq 0x1B) {
                # User pressed ESCAPE, we'll return -1
                $formReturnValue = -1
                $QUIT_FORM = $true
            }
        }
    }

    end {
        # Restore default console behaviour
        [console]::SetCursorPosition(0, [console]::WindowTop + [console]::WindowHeight)
        $null = [ConsoleAPI]::SetConsoleMode($hIn, $oldConMode)
        [console]::CursorVisible = $true
        return $formReturnValue
    }
}