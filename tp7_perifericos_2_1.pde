import processing.serial.*;

Serial puertoSerial;
boolean arduinoConectado = false;

int estadoL1 = 0;
int estadoL2 = 0;
int estadoE1 = 1;
int estadoE2 = 1;

void setup() {
  size(400, 300);
  background(240);

  try {
    printArray(Serial.list());
    String puerto = Serial.list()[0];
    puertoSerial = new Serial(this, puerto, 9600);
    puertoSerial.bufferUntil('\n');
    arduinoConectado = true;
    println("Arduino conectado en el puerto: " + puerto);
  } catch (Exception e) {
    println("Advertencia: No se detectó Arduino. Se simulará la comunicación.");
    arduinoConectado = false;
  }

  println("Sistema iniciado. Haz clic y mantén presionado E1 o E2.");
}

void draw() {
  background(240);

  // Simulamos datos de Arduino (si no está conectado)
  if (!arduinoConectado && frameCount % 60 == 0) {
    estadoE1 = int(random(0, 2));
    estadoE2 = int(random(0, 2));
    println("Simulación: Arduino envió E1:" + estadoE1 + ",E2:" + estadoE2);
  }

  // Dibujamos la interfaz (igual que antes)
  fill(100, 100, 255);
  rect(50, 50, 100, 40);
  fill(0);
  text("Entradas", 100, 70);

  fill(estadoE1 == 0 ? color(255, 0, 0) : color(255));
  ellipse(200, 70, 40, 40);
  fill(0);
  text("E1", 200, 70);

  fill(estadoE2 == 0 ? color(255, 0, 0) : color(255));
  ellipse(280, 70, 40, 40);
  fill(0);
  text("E2", 280, 70);

  fill(100, 255, 100);
  rect(50, 150, 100, 40);
  fill(0);
  text("Salidas", 100, 170);

  fill(estadoL1 == 1 ? color(0, 255, 0) : color(200));
  ellipse(200, 170, 40, 40);
  fill(0);
  text("L1", 200, 170);

  fill(estadoL2 == 1 ? color(0, 255, 0) : color(200));
  ellipse(280, 170, 40, 40);
  fill(0);
  text("L2", 280, 170);
}

void simularComunicacion(String comando) {
  println("Enviando a Arduino: " + comando);

  if (comando.equals("L1:1")) {
    estadoL1 = 1;
    println("Arduino respondió: L1 encendido");
  } else if (comando.equals("L1:0")) {
    estadoL1 = 0;
    println("Arduino respondió: L1 apagado");
  } else if (comando.equals("L2:1")) {
    estadoL2 = 1;
    println("Arduino respondió: L2 encendido");
  } else if (comando.equals("L2:0")) {
    estadoL2 = 0;
    println("Arduino respondió: L2 apagado");
  }
}

void serialEvent(Serial puertoSerial) {
  String dato = puertoSerial.readStringUntil('\n');
  dato = trim(dato);
  println("Recibido de Arduino: " + dato);

  if (dato != null) {
    String[] partes = split(dato, ',');
    for (String parte : partes) {
      String[] claveValor = split(parte, ':');
      if (claveValor[0].equals("E1")) {
        estadoE1 = int(claveValor[1]);
      } else if (claveValor[0].equals("E2")) {
        estadoE2 = int(claveValor[1]);
      }
    }
  }
}

void mousePressed() {
  if (mouseX > 180 && mouseX < 220 && mouseY > 50 && mouseY < 90) {
    println("Presionando E1");
    if (arduinoConectado) {
      puertoSerial.write("L1:1\n");
    } else {
      simularComunicacion("L1:1");
    }
  }

  if (mouseX > 260 && mouseX < 300 && mouseY > 50 && mouseY < 90) {
    println("Presionando E2");
    if (arduinoConectado) {
      puertoSerial.write("L2:1\n");
    } else {
      simularComunicacion("L2:1");
    }
  }
}

void mouseReleased() {
  println("Soltando clic");
  if (arduinoConectado) {
    puertoSerial.write("L1:0\n");
    puertoSerial.write("L2:0\n");
  } else {
    simularComunicacion("L1:0");
    simularComunicacion("L2:0");
  }
}
