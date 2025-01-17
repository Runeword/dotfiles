{
  outputs =
    { self }:
    {
      templates = {
        js.path = ./js;
        js.description = "js";
        js.welcomeText = "js";

        node.path = ./node;
        node.description = "node";
        node.welcomeText = "node";

        proto.path = ./proto;
        proto.description = "proto";
        proto.welcomeText = "proto";

        firebase.path = ./firebase;
        firebase.description = "firebase";
        firebase.welcomeText = "firebase";

        go.path = ./go;
        go.description = "go";
        go.welcomeText = "go";

        py.path = ./py;
        py.description = "py";
        py.welcomeText = "py";

        lambda.path = ./lambda;
        lambda.description = "lambda";
        lambda.welcomeText = "lambda";

        rust.path = ./rust;
        rust.description = "rust";
        rust.welcomeText = "rust";
      };
    };
}
