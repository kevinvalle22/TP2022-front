import 'package:flutter/material.dart';

class NewAccountPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Components(context),
    );
  }
}
Widget Components(BuildContext context){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/originals/1b/da/2f/1bda2fa61500b9e918cec3061e5507ca.jpg'),
            fit: BoxFit.cover
        )
        ),
    child: Center(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Name(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: UserField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: EmailField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: PhoneField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: PasswordField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: UniversityField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: ProvinceField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: DistrictField(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: CreateAccount(context),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: ComeBack(context),
          ),
          SizedBox(height: 50,)
        ],
      ),
    ),
    );

}

Widget Name(){
  return const Text("Crear Nueva Cuenta",style:TextStyle(color: Color.fromRGBO(67, 58, 108, 10),fontSize: 35.0,fontWeight: FontWeight.bold));
}

Widget UserField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Usuario",
          hintText: "usuario",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget EmailField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "usuario@mail.com",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget PhoneField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Número de celular",
          hintText: "(+51) 999-999-999",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget PasswordField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Contraseña",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget UniversityField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Universidad",
          hintText: "Universidad",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget ProvinceField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Provincia",
          hintText: "provincia",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget DistrictField(){
  return Container(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Distrito",
          hintText: "distrito",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget CreateAccount(BuildContext context){
  return Container(
    width: 320,
    height: 50,
    child: RaisedButton(
      color: Color.fromRGBO(104, 174, 174, 6),
      onPressed: ()
      {
        Navigator.of(context).pop();
      },
      child: Text("Crear Cuenta",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
  );
}


  @override
  Widget ComeBack(BuildContext context) {
    return Container(

      width: 320,
      height: 50,
      child: RaisedButton(

        color: Color.fromRGBO(146, 150, 187, 10),
        onPressed: ()
        {
          Navigator.of(context).pop();
        },
        child: const Text("¿YA TIENES CUENTA? INICIA AHORA", style: TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }

