import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Client autobetClient = Client()
    .setEndPointRealtime(dotenv.get("APPWRITE_ENDPOINT"))
    .setProject(dotenv.get("APPWRITE_PID"))
    .setSelfSigned(status: true);
Account autobetAccount = Account(autobetClient);
Databases autobetDatabese = Databases(autobetClient);
