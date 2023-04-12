{
  outputs = { self }: {
    templates.js.path = ./js;
    templates.js.welcomeText = "js";
    templates.proto.path = ./proto;
    templates.proto.welcomeText = "proto";
    templates.firebase.path = ./firebase;
    templates.firebase.welcomeText = "firebase";
  };
}
