# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  sumTotal = document.querySelector('.total');
  calculate = document.querySelector('.calculate');
  saveButton = document.querySelector('.save-btn');

  currencyFormat = (number) ->
    new (Intl.NumberFormat)('en-US',
      style: 'currency'
      currency: 'USD').format number

  isChecked = (element) ->
    if element.checked then Number(element.value) else 0

  generalCleaningTotal = (pph, pfj, hfj) ->
    pph * pfj * hfj

  extraCharge = (ftc, ecc, ref, cab, ovc) ->
    isChecked(ftc) + isChecked(ecc) + isChecked(ref) + isChecked(cab) + isChecked(ovc)
  
  windowCleaningTotal = (cm, cpm, ftc, ecc, ref, cab, ovc) ->
    extraCleaningCharge = extraCharge(ftc, ecc, ref, cab, ovc)
    (cm * cpm) + extraCleaningCharge
  
  showSaveButton = (total) ->
    if total > 0
      saveButton.classList.remove 'd-none'
    else
      saveButton.classList.add 'd-none'
    return


  calculateCustomQuote = ->
    generalCPPJ = document.querySelector('#people_per_job').value;
    generalCHFJ = document.querySelector('#hours_for_job').value;
    generalCPPH = document.querySelector('#price_per_hour').value;

    windowCM = document.querySelector('#mensuration').value;
    windowCCPM = document.querySelector('#cost_per_measurement').value;
    windowCD = document.querySelector('#discount').value;

    firstTimeCharge = document.querySelector('#first_time_charge');
    extraCleanCharge = document.querySelector('#extra_clean_charge');
    refrigeratorCharge = document.querySelector('#refrigerator_charge');
    cabinetsCharge = document.querySelector('#cabinets_charge');
    ovenCleanCharge = document.querySelector('#oven_clean_charge');
    
    subTotal = generalCleaningTotal(generalCPPJ, generalCPPH, generalCHFJ)
    subTotal += windowCleaningTotal(windowCM, windowCCPM, firstTimeCharge, extraCleanCharge, refrigeratorCharge, cabinetsCharge, ovenCleanCharge)
    discount = (windowCD/100) * subTotal
    total = subTotal - discount
    showSaveButton(total)

    sumTotal.innerHTML = currencyFormat(total)
    return

  calculateContractQuote = ->
    contractMV = document.querySelector('#monthly_visit').value;
    contractPPV = document.querySelector('#price_per_visit').value;
    contractCPM = document.querySelector('#cost_per_month');
    contractCM = document.querySelector('#contract_months').value;

    # calculate contract cost per month
    document.querySelector('#cost_per_month').value = contractMV * contractPPV

    total = (Number(contractMV) * Number(contractPPV)) * Number(contractCM)
    showSaveButton(total)

    sumTotal.innerHTML = currencyFormat(total)
    return

  saveQuote = ->
    data = {}
    forms = document.querySelectorAll('form');
    forms.forEach (form) ->
      data[form.id] = {}
      for input in form.elements
        if input.type == 'checkbox'
          if input.checked
            data[form.id][input.id] = input.value
        if input.type == 'number'
          data[form.id][input.id] = input.value
      return
    console.log data

  if document.location.pathname.endsWith('custom')
    calculate.onclick = ->
      calculateCustomQuote()
    saveButton.onclick = ->
      saveQuote()

  if document.location.pathname.endsWith('contract')
    calculate.onclick = ->
      calculateContractQuote()
    saveButton.onclick = ->
      saveQuote()

  return
