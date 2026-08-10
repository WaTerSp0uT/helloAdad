# helloAdad

TC # 1 

When 
Then 
Then
AND
Then System.out.println("Code is done FINISHHHH");


TC # 2 

When 
Then 
Then
AND
Then System.out.println("Code is done FINISHHHH");



Let me walk you through our Playwright Java Cucumber automation framework and explain how a test moves through it.
The workflow begins with Maven and the JUnit runner. When we execute mvn test, Maven loads the dependencies and build settings from the pom.xml file. The PlaywrightTestRunner then starts Cucumber and selects the scenarios that should run. We can use Cucumber tags to run a particular application, test type, or group of scenarios.
Next, Cucumber reads the feature files. Feature files describe the tests in plain Gherkin language using Given, When, and Then steps. This allows technical and nontechnical team members to understand the expected business behavior.
Cucumber then matches every Gherkin step with a Java method in the step-definition layer. CommonPlaywrightSteps contains reusable steps, such as navigating to a URL. Application-specific behavior is placed in classes such as OrangeHRMPlaywrightSteps.
The step definitions do not contain all the browser locators and detailed UI interactions. Instead, they call the Page Object Model. For example, OrangeHRMLoginPage contains the locators and actions needed to work with the OrangeHRM login page. This separation makes the tests easier to read and maintain. If a locator changes, we normally update it in one page-object class instead of changing multiple scenarios.
The page object communicates with the application through the Playwright engine. PlaywrightFactory creates and manages the Playwright instance, browser, browser context, and page. The browser context provides an isolated browser session, while the page represents the browser tab used by the test.
The factory uses thread-local storage, so each parallel test thread receives its own Playwright objects. This helps prevent one scenario from interfering with another scenario during parallel execution.
The framework reads browser settings from Configs/config.properties. These settings control the browser type, headless mode, timeout, viewport size, tracing, screenshots, and other execution options. We can also override many of these settings from the Maven command line.
Test credentials are not stored directly in the feature files or source code. SecretConfigReader resolves them from a local .env file, JVM -D properties, or CI environment variables. This allows the same tests to run locally and in a pipeline without exposing credentials in the codebase.
The utilities layer provides shared functionality across the framework. Library reads configuration values, SecretConfigReader handles credentials, SoftAssert supports grouped validations, Constants stores reusable test values, and VisualComparisonUtil supports image-based validation.
PlaywrightHooks manages the lifecycle of each scenario. Before execution, the hooks prepare scenario-level settings and log the active thread. After each step, they can capture a screenshot depending on the configured screenshot mode. After the scenario finishes, they close the page, browser context, browser, and Playwright resources.
During execution, Playwright performs the actual browser actions against the application under test. These actions include navigation, entering data, clicking elements, waiting for content, and validating the application’s response.
Finally, the framework produces several test outputs. Cucumber generates HTML and JSON reports. Extent Reports generates a visual Spark HTML report and a PDF report. The framework can also attach screenshots, save Playwright traces, and create a failed-test rerun file.
If a scenario fails, its location is written to target/playwright-failed.txt. We can then run the failed-test runner to execute only those failed scenarios instead of rerunning the entire test suite.
So, in one sentence, the complete workflow is:
Business requirements are written as feature scenarios, mapped to Java step definitions, implemented through reusable page objects, executed in the browser by Playwright, managed by hooks and utilities, and documented through reports, screenshots, traces, and rerun files.”
A concise closing statement would be:
“The main benefit of this structure is separation of responsibilities. Feature files describe what we test, step definitions connect the business language to Java, page objects describe how we interact with the application, and Playwright performs the browser automation.”
