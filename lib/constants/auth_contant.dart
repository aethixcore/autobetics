import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Client autobetClient = Client()
    .setEndpoint(dotenv.get("APPWRITE_ENDPOINT"))
    .setProject(dotenv.get("APPWRITE_PID"));
Account autobetAccount = Account(autobetClient);
Databases autobetDatabase = Databases(autobetClient);
Storage autobetStorage = Storage(autobetClient);
