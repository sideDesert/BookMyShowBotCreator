// import { getNames } from "./persona-generator.js";
import puppeteer from "puppeteer";
import { getOtp } from "./readOTP.js";
import fs from "fs";
const IS_PRODUCTION = process.env.NODE_ENV === "production";

// puppeteer.launch() => Chrome running locally (on the same hardware)
let browser = null;

const classNames = {
  modal: ".bwc__sc-1ihur1g-4",
  continue: ".hmbiuL",
  citiesList: ".bwc__sc-ttnkwg-19",
};

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

    await page.waitForSelector(classNames.modal, { visible: true });
    // Select Hyderabad
    console.log("Selecting Location as Hyderabad...");

    await page.evaluate(() => {
      const els = document.querySelectorAll(".bwc__sc-ttnkwg-19");
      els[3].click();
    });

    // Click on SignIn and then Click on custom EMail
    console.log("Clicking on Sign In...");
    let signInButton = await page.waitForSelector("div.bwc__sc-1nbn7v6-14");
    await signInButton.click();

    await page.evaluate(() => {
      let buttons = document.querySelectorAll("div.bwc__sc-dh558f-10");
      if (buttons.length > 0) {
        buttons[1].children[0].click();
      }
    });

    console.log("Typing Email...");
    // await page..nshot({ path: "screenshot.png" });

    await page.waitForSelector("input#emailId", { visible: true });
    await page.type("input#emailId", email, { delay: 0.03 });
    await page.waitForSelector("button" + classNames.continue, {
      visible: true,
    });

    const contButton = await page.waitForSelector("button.hmbiuL", {
      visible: true,
    });
    if (contButton) {
      console.log("Clicking on Continue");
      await contButton.click();
    }

    // await page.screenshot({ path: "screenshot.png" });
    const otp = await getOtp(email);
    const otpInput = await page.waitForSelector("input.bwc__sc-rwpctr-1");
    // await page.screenshot({ path: `${email}-otp.png` });
    await page.type("input.bwc__sc-rwpctr-1", otp, { delay: 0.1 });

    await page.screenshot({ path: `${email}.png` });
  } catch (error) {
    console.log(error);
  } finally {
    if (browser) {
      await browser.close();
    }
  }
}

signUp("newdhar@adhva.co");
// const retryButton = await page.$x('//button[contains(text(), "Retry")]');
