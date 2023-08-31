import fNames from "./fnames.json" assert { type: "json" };
import lNames from "./lnames.json" assert { type: "json" };

export function getName() {
  let randomIndex = Math.floor(Math.random() * fNames.length);

  const fn = fNames[randomIndex];
  randomIndex = Math.floor(Math.random() * lNames.length);

  const ln = lNames[randomIndex];

  const n = `${fn} ${ln}`;
  return n;
}

export function getNames(n = 10000) {
  let names = [];
  for (let i = 0; i < n; i++) {
    names.push(getName());
  }
  console.log(names);
}
