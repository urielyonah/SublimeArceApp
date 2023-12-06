import 'dart:io';
import 'package:ejercicio1/bd/UserData.dart';
import 'package:ejercicio1/vistas/cartView.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path/path.dart' as path;

Future<void> generarPDF(List<Carrito> carritos) async {
  final pdf = pw.Document();

  for (final carrito in carritos) {
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Nombre del Producto: ${carrito.nombreProductos}'),
            pw.Text('Descripción: ${carrito.descripcionProductos}'),
            pw.Text('Precio: \$${carrito.precioProductos.toStringAsFixed(2)}'),
            // Agrega más detalles según sea necesario
          ],
        ),
      ),
    );
  }

  final bytes = await pdf.save();

  // Guarda el archivo PDF localmente o puedes enviarlo directamente por correo electrónico
  // Puedes usar el paquete path_provider para obtener el directorio de documentos en el dispositivo

  // Obtén el directorio de documentos de una manera compatible con tu entorno
  final String documentsDir = await getDocumentsDirectory();
  final String filePath = path.join(documentsDir, 'detalles_pedido.pdf');
  final tempFile = File(filePath);

  if (await tempFile.exists()) {
    await tempFile.delete();
  }

  await tempFile.writeAsBytes(bytes);

  // Envía el PDF por correo electrónico
  await enviarCorreoElectronico(tempFile);
}

Future<void> enviarCorreoElectronico(File file) async {
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'urielyonah@gmail.com', password: 'Yonah#2000.', ssl: true);

  final message = Message()
    ..from = Address('${UserData().userEmail}', '${UserData().userName}')
    ..recipients.add(Address('urielyonah@gmail.com'))
    ..subject = 'Detalles del Pedido'
    ..attachments.add(FileAttachment(file));

  try {
    final sendReport = await send(message, smtpServer);
    print('Correo electrónico enviado: ${sendReport}');
  } on MailerException catch (e) {
    print('Error al enviar el correo electrónico: $e');
  }
}

Future<String> getDocumentsDirectory() async {
  if (Platform.isAndroid) {
    return '/storage/emulated/0/Download'; // Puedes ajustar esto según tu necesidad
  } else if (Platform.isIOS) {
    return '/path/to/documents'; // Puedes ajustar esto según tu necesidad
  } else {
    throw UnsupportedError('Plataforma no soportada');
  }
}
