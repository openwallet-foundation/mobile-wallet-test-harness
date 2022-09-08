import os
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from pageobjects.basepage import BasePage
from pageobjects.bc_wallet.initialization import InitializationPage

class OnboardingBiometricsPage(BasePage):
    """Onboarding Biometrics page object"""

    # Locators
    on_this_page_text_locator = "you will need to use biometrics to open your BC Wallet"
    # toggle no longer exists in build 305
    #use_biometrics_toggle_locator = (AppiumBy.ID, "com.ariesbifold:id/ToggleBiometrics")
    continue_button_locator = (AppiumBy.ID, "com.ariesbifold:id/Continue")


    def on_this_page(self):   
        timeout = 50
        if "Local" in os.environ['DEVICE_CLOUD']:
            timeout = 100
        return super().on_this_page(self.on_this_page_text_locator, timeout)  

    # this no longer exists in build 305 but leaving it in as it is uncertain if it will come back.
    def select_biometrics(self):
        if self.on_this_page():
            self.find_by(self.use_biometrics_toggle_locator).click()
            return True
        else:
            raise Exception(f"App not on the {type(self)} page")


    def select_continue(self):
        if self.on_this_page():
            self.find_by(self.continue_button_locator).click()

            # return the wallet initialization page
            return InitializationPage(self.driver)
        else:
            raise Exception(f"App not on the {type(self)} page")
