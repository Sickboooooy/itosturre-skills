# Screenshot — Captura de pantalla y envío por Telegram

Captura el escritorio de Windows desde WSL2 y envía la imagen por Telegram a Fabián (chat_id: 6621648166).

## Pasos

1. Ejecuta este comando PowerShell para capturar la pantalla:

```bash
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; \$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; \$bitmap = New-Object System.Drawing.Bitmap \$screen.Width, \$screen.Height; \$graphics = [System.Drawing.Graphics]::FromImage(\$bitmap); \$graphics.CopyFromScreen(\$screen.Location, [System.Drawing.Point]::Empty, \$screen.Size); \$bitmap.Save('C:\\temp\\screenshot.png'); Write-Output 'OK'"
```

2. Verifica que el archivo existe en `/mnt/c/temp/screenshot.png`

3. Envía la imagen por Telegram usando el tool `mcp__plugin_telegram_telegram__reply` con:
   - chat_id: "6621648166"
   - text: "📸 Screenshot — [fecha y hora actual]"
   - files: ["/mnt/c/temp/screenshot.png"]

4. Confirma en consola que fue enviada.

## Notas
- La captura es del monitor principal (PrimaryScreen)
- El archivo se sobreescribe en cada captura en `/mnt/c/temp/screenshot.png`
- No requiere instalar nada adicional — usa PowerShell interop de WSL2
