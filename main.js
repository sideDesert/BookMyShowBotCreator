// import { getNames } from "./persona-generator.js";
import puppeteer from "puppeteer";
import { getOtp } from "./readOTP.js";
import fs from "fs";
const IS_PRODUCTION = process.env.NODE_ENV === "production";

// puppeteer.launch() => Chrome running locally (on the same hardware)
let browser = null;

console.log("Opening Browser..");

async function signUp(email) {
  try {
    browser = await puppeteer.connect({
      browserWSEndpoint:
        "wss://chrome.browserless.io?token=2dc59b11-de49-4607-b754-e3874bb26caf&stealth",
    });
    const page = await browser.newPage();
    await page.setViewport({ width: 1280, height: 720 });
    console.log("Going to Book My Show");
    await page.goto("https://www.bookmyshow.com/");

    await page.waitForXPath("//*[@id='modal-root']/div", { visible: true });
    // Select Hyderabad
    console.log("Selecting Location as Hyderabad...");

    const hydSpan = await page.$x("//span[text()='Hyderabad']");
    await hydSpan[hydSpan.length].click();

    // Click on SignIn and then Click on custom EMail
    console.log("Clicking on Sign In...");
    let signInButton = await page.waitForXPath(
      "//button[contains(text(), 'Sign')]"
    );
    await signInButton.click();

    await page.evaluate(() => {
      let buttons = $x("//*[@id='modal-root']//div[contains(text(),'Email')]");
      if (buttons.length > 0) {
        buttons[0].click();
      } else {
        console.log("Error: While Signing In Email Button NOT FOUND");
      }
    });

    console.log("Typing Email...");
    // await page..nshot({ path: "screenshot.png" });

    await page.waitForSelector("input#emailId", { visible: true });
    await page.type("input#emailId", email, { delay: 0.03 });
    await page.waitForSelector("button" + classNames.continue, {
      visible: true,
    });

    const contButton = await page.waitForXPath(
      '//form//button[contains(text(), "Continue")]',
      {
        visible: true,
      }
    )[0];
    setTimeout(async () => {
      if (contButton) {
        console.log("Clicking on Continue");
        await contButton.click();
      }
    }, 600);

    // await page.screenshot({ path: "screenshot.png" });
    let otp = await getOtp(email);
    while (otp.length == 0) {
      otp = await getOtp(email);
    }
    const otpInput = await page.waitForSelector(
      '//*[@id="modal-root"]//form/div[1]/div[3]/input[1]'
    );
    // await page.screenshot({ path: `${email}-otp.png` });
    await otpInput.type(otp, { delay: 0.1 });

    await page.screenshot({ path: `${email}.png` });
  } catch (error) {
    console.log(error);
  } finally {
    if (browser) {
      await browser.close();
    }
    dsfsdfsf;
  }
}

signUp("newdhar@adhva.co");
// const retryButton = await page.$x('//button[contains(text(), "Retry")]');
