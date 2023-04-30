import { issueJWT } from "./lib/utils.js";

console.log("Usuario")
console.log(issueJWT("650b5bf2-e7c0-4815-b97a-75b0935e852d"))

console.log("Conductor")
console.log(issueJWT("64c741eb-a3e5-4fce-9125-bfc521acf91d"))

console.log("Gestor")
console.log(issueJWT("90e60a0d-564a-49b5-8e1d-29b6dc8376ab"))
