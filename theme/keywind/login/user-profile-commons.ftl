<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>

<#macro userProfileFormFields>
    <#assign currentGroup="">

    <#list profile.attributes as attribute>

        <#assign groupName = attribute.group!"">
        <#if groupName != currentGroup>
            <#assign currentGroup=groupName>
            <#if currentGroup != "" >
              <div class="${properties.kcFormGroupClass!}">

                  <#assign groupDisplayHeader=attribute.groupDisplayHeader!"">
                  <#if groupDisplayHeader != "">
                      <#assign groupHeaderText=advancedMsg(attribute.groupDisplayHeader)!groupName>
                  <#else>
                      <#assign groupHeaderText=groupName>
                  </#if>
                <div class="${properties.kcContentWrapperClass!}">
                  <label id="header-${groupName}" class="${kcFormGroupHeader!}">${groupHeaderText}</label>
                </div>

                  <#assign groupDisplayDescription=attribute.groupDisplayDescription!"">
                  <#if groupDisplayDescription != "">
                      <#assign groupDescriptionText=advancedMsg(attribute.groupDisplayDescription)!"">
                    <div class="${properties.kcLabelWrapperClass!}">
                      <label id="description-${groupName}" class="${properties.kcLabelClass!}">${groupDescriptionText}</label>
                    </div>
                  </#if>
              </div>
            </#if>
        </#if>

        <#nested "beforeField" attribute>
      <div class="${properties.kcFormGroupClass!}">
        <div class="${properties.kcLabelWrapperClass!}">
          <label for="${attribute.name}" class="${properties.kcLabelClass!}">${advancedMsg(attribute.displayName!'')}</label>
            <#if attribute.required>*</#if>
        </div>
        <div class="${properties.kcInputWrapperClass!}">
            <#if attribute.annotations.inputHelperTextBefore??>
              <div
                      class="${properties.kcInputHelperTextBeforeClass!}"
                      id="form-help-text-before-${attribute.name}"
                      aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
            </#if>
            <@inputFieldByType attribute=attribute/>
            <#if attribute.annotations.inputHelperTextAfter??>
              <div
                      class="${properties.kcInputHelperTextAfterClass!}"
                      id="form-help-text-after-${attribute.name}"
                      aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextAfter))?no_esc}</div>
            </#if>
        </div>
      </div>
        <#nested "afterField" attribute>
    </#list>
</#macro>

<#macro inputFieldByType attribute>
    <#switch attribute.annotations.inputType!''>
        <#case 'textarea'>
            <@textareaTag attribute=attribute/>
            <#break>
        <#case 'select'>
        <#case 'multiselect'>
            <@selectTag attribute=attribute/>
            <#break>
        <#case 'select-radiobuttons'>
        <#case 'multiselect-checkboxes'>
            <@inputTagSelects attribute=attribute/>
            <#break>
        <#default>
            <@inputTag attribute=attribute/>
    </#switch>
</#macro>


<#macro inputTag attribute>
  <input
          type="<@inputTagType attribute=attribute/>"
          id="${attribute.name}"
          name="${attribute.name}"
          value="${(attribute.value!'')}"
          class="${properties.kcInputClass!}"
          aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
          <#if attribute.readOnly>disabled</#if>
          <#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>
          <#if attribute.annotations.inputTypePlaceholder??>placeholder="${attribute.annotations.inputTypePlaceholder}"</#if>
          <#if attribute.annotations.inputTypePattern??>pattern="${attribute.annotations.inputTypePattern}"</#if>
          <#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
          <#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
          <#if attribute.annotations.inputTypeMinlength??>minlength="${attribute.annotations.inputTypeMinlength}"</#if>
          <#if attribute.annotations.inputTypeMax??>max="${attribute.annotations.inputTypeMax}"</#if>
          <#if attribute.annotations.inputTypeMin??>min="${attribute.annotations.inputTypeMin}"</#if>
          <#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
  />
</#macro>

<#--<#macro inputTag attribute>-->
<#--    <@input.kw-->
<#--    type="text"-->
<#--    id="${attribute.name}"-->
<#--    name="${attribute.name}"-->
<#--    value="${(attribute.value!'')}"-->
<#--    class="${properties.kcInputClass!}"-->
<#--    invalid=messagesPerField.existsError('${attribute.name}')-->
<#--    message=kcSanitize(messagesPerField.get('${attribute.name}'))-->
<#--    &lt;#&ndash;    placeholder="${attribute.annotations.inputTypePlaceholder}"&ndash;&gt;-->
<#--    &lt;#&ndash;    pattern="${attribute.annotations.inputTypePattern}"&ndash;&gt;-->
<#--    &lt;#&ndash;    size="${attribute.annotations.inputTypeSize}"&ndash;&gt;-->
<#--    &lt;#&ndash;    maxlength="${attribute.annotations.inputTypeMaxlength}"&ndash;&gt;-->
<#--    &lt;#&ndash;    minlength="${attribute.annotations.inputTypeMinlength}"&ndash;&gt;-->
<#--    &lt;#&ndash;    max="${attribute.annotations.inputTypeMax}"&ndash;&gt;-->
<#--    &lt;#&ndash;    min="${attribute.annotations.inputTypeMin}"&ndash;&gt;-->
<#--    &lt;#&ndash;    step="${attribute.annotations.inputTypeStep}"&ndash;&gt;-->
<#--    &lt;#&ndash;					TODO&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.readOnly>disabled</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypePlaceholder??>placeholder="${attribute.annotations.inputTypePlaceholder}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypePattern??>pattern="${attribute.annotations.inputTypePattern}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeMinlength??>minlength="${attribute.annotations.inputTypeMinlength}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeMax??>max="${attribute.annotations.inputTypeMax}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeMin??>min="${attribute.annotations.inputTypeMin}"</#if>&ndash;&gt;-->
<#--    &lt;#&ndash;              <#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>&ndash;&gt;-->
<#--    />-->
<#--</#macro>-->

<#macro inputTagType attribute>
    <#compress>
        <#if attribute.annotations.inputType??>
            <#if attribute.annotations.inputType?starts_with("html5-")>
                ${attribute.annotations.inputType[6..]}
            <#else>
                ${attribute.annotations.inputType}
            </#if>
        <#else>
          text
        </#if>
    </#compress>
</#macro>

<#macro textareaTag attribute>
  <textarea
          id="${attribute.name}" name="${attribute.name}" class="${properties.kcInputClass!}"
          aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
          <#if attribute.readOnly>disabled</#if>
          <#if attribute.annotations.inputTypeCols??>cols="${attribute.annotations.inputTypeCols}"</#if>
          <#if attribute.annotations.inputTypeRows??>rows="${attribute.annotations.inputTypeRows}"</#if>
          <#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
	>${(attribute.value!'')}</textarea>
</#macro>

<#macro selectTag attribute>
  <select
          id="${attribute.name}" name="${attribute.name}" class="${properties.kcInputClass!}"
          aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
          <#if attribute.readOnly>disabled</#if>
          <#if attribute.annotations.inputType=='multiselect'>multiple</#if>
          <#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
  >
      <#if attribute.annotations.inputType=='select'>
        <option value=""></option>
      </#if>

      <#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
          <#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
      <#elseif attribute.validators.options?? && attribute.validators.options.options??>
          <#assign options=attribute.validators.options.options>
      </#if>

      <#if options??>
          <#list options as option>
            <option
                    value="${option}"
                    <#if attribute.values?seq_contains(option)>selected</#if>><@selectOptionLabelText attribute=attribute option=option/></option>
          </#list>
      </#if>
  </select>
</#macro>

<#macro inputTagSelects attribute>
    <#if attribute.annotations.inputType=='select-radiobuttons'>
        <#assign inputType='radio'>
        <#assign classDiv=properties.kcInputClassRadio!>
        <#assign classInput=properties.kcInputClassRadioInput!>
        <#assign classLabel=properties.kcInputClassRadioLabel!>
    <#else>
        <#assign inputType='checkbox'>
        <#assign classDiv=properties.kcInputClassCheckbox!>
        <#assign classInput=properties.kcInputClassCheckboxInput!>
        <#assign classLabel=properties.kcInputClassCheckboxLabel!>
    </#if>

    <#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
        <#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
    <#elseif attribute.validators.options?? && attribute.validators.options.options??>
        <#assign options=attribute.validators.options.options>
    </#if>

    <#if options??>
        <#list options as option>
          <div class="${classDiv}">
              <@input.kw
              type="${inputType}" id="${attribute.name}-${option}" name="${attribute.name}" value="${option}" class="${classInput}"
              invalid=messagesPerField.existsError('${attribute.name}')
              message=kcSanitize(messagesPerField.get('${attribute.name}'))
              <#--							TODO-->
              <#--                    <#if attribute.readOnly>disabled</#if>-->
              <#--                    <#if attribute.values?seq_contains(option)>checked</#if>-->
              />
            <label
                    for="${attribute.name}-${option}"
                    class="${classLabel}<#if attribute.readOnly> ${properties.kcInputClassRadioCheckboxLabelDisabled!}</#if>"><@selectOptionLabelText attribute=attribute option=option/></label>
          </div>
        </#list>
    </#if>
  </select>
</#macro>

<#macro selectOptionLabelText attribute option>
    <#compress>
        <#if attribute.annotations.inputOptionLabels??>
            ${advancedMsg(attribute.annotations.inputOptionLabels[option]!option)}
        <#else>
            <#if attribute.annotations.inputOptionLabelsI18nPrefix??>
                ${msg(attribute.annotations.inputOptionLabelsI18nPrefix + '.' + option)}
            <#else>
                ${option}
            </#if>
        </#if>
    </#compress>
</#macro>
