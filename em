Hi [Manager’s Name],
I wanted to let you know that I’m planning to take some time off from October 6th through October 17th for a family vacation. I’ll be sending you an official email shortly with the formal request, but just wanted to give you a heads-up first.
I’ve also spoken with Julia and she’s agreed to cover all of my responsibilities during this period, so there will be full coverage while I’m away.
Thanks!


Subject: Vacation Request: October 6th – October 17th
Dear [Manager’s Name],
I hope this message finds you well.
I am writing to formally request vacation leave from October 6th through October 17th as I will be taking a family vacation during this time.
To ensure that work continues smoothly in my absence, I have coordinated with Julia and she has kindly agreed to cover all of my responsibilities while I am away.
Please let me know if you need any additional information or if there are any concerns regarding this request.
Thank you very much for your understanding and support.
Best regards,

import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

public class ElementUtils {

    private static final int DEFAULT_TIMEOUT_SEC = 10;

    /**
     * Find first element with exact attribute=value match.
     * Example: findByAttr(driver, "*", "data-test", "login-btn", 10)
     */
    public static WebElement findByAttr(WebDriver driver,
                                        String tag,
                                        String attribute,
                                        String value,
                                        int timeoutSeconds) {
        if (tag == null || tag.isBlank()) tag = "*";
        String predicate = String.format("@%s=%s", attribute, toXPathLiteral(value));
        String xpath = String.format("//%s[%s]", tag, predicate);
        return new WebDriverWait(driver, Duration.ofSeconds(timeoutSeconds))
                .until(ExpectedConditions.presenceOfElementLocated(By.xpath(xpath)));
    }

    /** Overload with default tag=* and default timeout */
    public static WebElement findByAttr(WebDriver driver, String attribute, String value) {
        return findByAttr(driver, "*", attribute, value, DEFAULT_TIMEOUT_SEC);
    }

    /**
     * Contains-match version (useful for partial values).
     * Example: //*[contains(@placeholder,'email')]
     */
    public static WebElement findByAttrContains(WebDriver driver,
                                                String tag,
                                                String attribute,
                                                String value,
                                                int timeoutSeconds) {
        if (tag == null || tag.isBlank()) tag = "*";
        String predicate = String.format("contains(@%s,%s)", attribute, toXPathLiteral(value));
        String xpath = String.format("//%s[%s]", tag, predicate);
        return new WebDriverWait(driver, Duration.ofSeconds(timeoutSeconds))
                .until(ExpectedConditions.presenceOfElementLocated(By.xpath(xpath)));
    }

    /** Case-insensitive exact match using translate() */
    public static WebElement findByAttrEqualsIgnoreCase(WebDriver driver,
                                                        String tag,
                                                        String attribute,
                                                        String value,
                                                        int timeoutSeconds) {
        if (tag == null || tag.isBlank()) tag = "*";
        String lower = value.toLowerCase();
        // translate(@attr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'value'
        String predicate = String.format(
                "translate(@%s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')=%s",
                attribute, toXPathLiteral(lower));
        String xpath = String.format("//%s[%s]", tag, predicate);
        return new WebDriverWait(driver, Duration.ofSeconds(timeoutSeconds))
                .until(ExpectedConditions.presenceOfElementLocated(By.xpath(xpath)));
    }

    /**
     * Safely turn any Java string into an XPath string literal.
     * Handles values containing both single and double quotes by using concat().
     */
    private static String toXPathLiteral(String s) {
        if (!s.contains("'")) {
            return "'" + s + "'";
        }
        if (!s.contains("\"")) {
            return "\"" + s + "\"";
        }
        // Need concat('part1',"'",'part2',"'",'part3',...)
        String[] parts = s.split("'");
        StringBuilder concat = new StringBuilder("concat(");
        for (int i = 0; i < parts.length; i++) {
            if (!parts[i].isEmpty()) {
                concat.append("'").append(parts[i]).append("'");
            }
            if (i < parts.length - 1) {
                concat.append(",\"'\","); // insert a literal single-quote between parts
            }
        }
        concat.append(")");
        return concat.toString();
    }
}


public void clickCheckboxIfRowExists(WebDriver driver, String searchText) {
    String xpath = String.format(
        "//tr[td[contains(normalize-space(.), '%s')]]//td[1]//input[@type='checkbox']",
        searchText
    );

    List<WebElement> elements = driver.findElements(By.xpath(xpath));

    if (!elements.isEmpty()) {
        WebElement checkbox = elements.get(0);
        if (!checkbox.isSelected()) {
            checkbox.click();
        }
        System.out.println("Checkbox clicked for row: " + searchText);
    } else {
        System.out.println("Row with text '" + searchText + "' not found. Skipping...");
    }
}
