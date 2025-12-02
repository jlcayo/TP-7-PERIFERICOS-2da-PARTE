# TP7 Periféricos - Control de E/S con Arduino y Processing

## Descripción
Sistema de control de entradas (pulsadores) y salidas (LEDs) con **Arduino** y una interfaz gráfica en **Processing**.
- **Arduino**: Lee el estado de 2 pulsadores y controla 2 LEDs. Se comunica con Processing por puerto serial.
- **Processing**: Muestra el estado de las entradas (`E1`, `E2`) y permite controlar los LEDs (`L1`, `L2`) desde la interfaz.

## Componentes
- **Hardware**:
  - Arduino UNO.
  - 2 pulsadores (conectados a pines 2 y 3 con `INPUT_PULLUP`).
  - 2 LEDs (con resistencias de 220Ω en pines 4 y 5).
- **Software**:
  - Arduino IDE (para cargar el código en la placa).
  - Processing (para ejecutar la interfaz gráfica).
## Esquematico
<img width="1031" height="448" alt="image" src="https://github.com/user-attachments/assets/02d85131-b7a3-4829-9f0f-4eda4edb05ad" />

