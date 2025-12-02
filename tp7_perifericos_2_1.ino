//definimos pines de entrada
const int pulsador1 = 2;
const int pulsador2 = 3;

//definimos pines de salida
const int led1 = 4;      
const int led2 = 5;      

void setup() {
  pinMode(pulsador1, INPUT_PULLUP);
  pinMode(pulsador2, INPUT_PULLUP);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);

  Serial.begin(9600);

 
  Serial.println("Sistema iniciado");
}

void loop() {
  //leemos el estado de los pulsadores
  int estadoPulsador1 = digitalRead(pulsador1);
  int estadoPulsador2 = digitalRead(pulsador2);

  // Enviamos el estado de las entradas a Processing por el puerto serial
  //"E1:0,E2:1" (0 = presionado, 1 = no presionado)
  Serial.print("E1:");
  Serial.print(estadoPulsador1 == LOW ? "0" : "1");  // Convertimos LOW a 0 y HIGH a 1
  Serial.print(",E2:");
  Serial.println(estadoPulsador2 == LOW ? "0" : "1");

  // Controlamos los LEDs según el estado de los pulsadores
  // Si el pulsador está presionado (LOW), encendemos el LED correspondiente
  digitalWrite(led1, estadoPulsador1 == LOW ? HIGH : LOW);
  digitalWrite(led2, estadoPulsador2 == LOW ? HIGH : LOW);

  // Pequeña pausa para evitar rebotes en los pulsadores (100ms)
  delay(100);

  // Si hay datos disponibles en el puerto serial (desde Processing)
  if (Serial.available() > 0) {
    String dato = Serial.readStringUntil('\n');  // Leemos hasta el salto de línea
    dato.trim();  // Eliminamos espacios o saltos adicionales

    // Procesamos los datos recibidos (ejemplo: "L1:1" para encender LED 1)
    if (dato.startsWith("L1:")) {
      int estadoLED1 = dato.substring(3).toInt();  // Extraemos el valor después de "L1:"
      digitalWrite(led1, estadoLED1 == 1 ? HIGH : LOW);
    }
    else if (dato.startsWith("L2:")) {
      int estadoLED2 = dato.substring(3).toInt();  // Extraemos el valor después de "L2:"
      digitalWrite(led2, estadoLED2 == 1 ? HIGH : LOW);
    }
  }
}
