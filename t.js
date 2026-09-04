/*async function test() {
  console.log("1");     // يتنفذ فورًا لما تستدعي الدالة
  return "تم";
}

test().then(result);       // الدالة تبدأ تتنفذ
console.log("2");*/
async function test() {
  console.log("1");
  return "تم";
}

test().then((result) => {
  console.log(result);
});

console.log("2");       // بعدين هذا
