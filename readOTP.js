import axios from "axios";

const url = "http://adhva.co/api/v2/search";

export async function getOtp(email) {
  const queryParams = {
    kind: "to",
    query: email,
    start: 0,
    limit: 1,
  };
  let otp = "";
  try {
    const res = await axios.get(url, { params: queryParams });
    otp = res.data;
    const items = res.data.items;
    if (items.length > 0) {
      otp = items[0]?.Content?.Headers?.Subject[0].split(" ")[0];
    }
  } catch (err) {
    console.log(err);
  }

  return otp;
}
