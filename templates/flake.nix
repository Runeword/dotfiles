{
  outputs = { self }: {
    templates = {
      js.path = ./js;
      js.description = "js";
      js.welcomeText = "js";

      proto.path = ./proto;
      proto.description = "proto";
      proto.welcomeText = "proto";

      firebase.path = ./firebase;
      firebase.description = "firebase";
      firebase.welcomeText = "firebase";
    };
  };
}
