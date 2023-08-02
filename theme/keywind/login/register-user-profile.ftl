<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <@form.kw id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">

            <@userProfileCommons.userProfileFormFields; callback, attribute>
                <#if callback = "afterField">
                <#-- render password fields just under the username or email (if used as username) -->
                    <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                      <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                          <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label> *
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <@input.kw
                            type="password" id="password" class="${properties.kcInputClass!}" name="password"
                            autocomplete="new-password"
                            invalid=messagesPerField.existsError('password','password-confirm')
                            message=kcSanitize(messagesPerField.get("password"))
                            />
                        </div>
                      </div>

                      <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                          <label
                                  for="password-confirm"
                                  class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label> *
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <@input.kw
                            type="password" id="password-confirm" class="${properties.kcInputClass!}"
                            name="password-confirm"
                            invalid=messagesPerField.existsError('password-confirm')
                            message=kcSanitize(messagesPerField.get('password-confirm'))
                            />
                        </div>
                      </div>
                    </#if>
                </#if>
            </@userProfileCommons.userProfileFormFields>

            <@registerCommons.termsAcceptance/>

            <#if recaptchaRequired??>
              <div class="form-group">
                <div class="${properties.kcInputWrapperClass!}">
                  <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
              </div>
            </#if>

          <div class="${properties.kcFormGroupClass!}">
            <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
              <div class="${properties.kcFormOptionsWrapperClass!}">
                <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
              </div>
            </div>

              <@buttonGroup.kw>
                  <@button.kw color="primary" type="submit">
                      ${msg("doRegister")}
                  </@button.kw>
              </@buttonGroup.kw>
          </div>
        </@form.kw>
    </#if>
</@layout.registrationLayout>
