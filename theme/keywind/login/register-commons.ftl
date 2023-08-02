<#import "components/atoms/checkbox.ftl" as checkbox>

<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>
      <div class="form-group">
        <div class="${properties.kcInputWrapperClass!}">
            ${msg("termsTitle")}
          <div id="kc-registration-terms-text">
              ${kcSanitize(msg("termsText"))?no_esc}
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="${properties.kcLabelWrapperClass!}">
            <@checkbox.kw id="termsAccepted" name="termsAccepted" class="${properties.kcCheckboxInputClass!}"
            invalid=messagesPerField.existsError('termsAccepted')
            message=kcSanitize(messagesPerField.get('termsAccepted'))
            />
          <label for="termsAccepted" class="${properties.kcLabelClass!}">${msg("acceptTerms")}</label>
        </div>
      </div>
    </#if>
</#macro>
