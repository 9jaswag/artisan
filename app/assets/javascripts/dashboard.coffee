# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  # select form inputs
  sumTotal = document.querySelector('.total');
  calculate = document.querySelector('.calculate');

  isChecked = (element) ->
    if element.checked
      Number(element.value)
    else
      0

  generalCleaningTotal = (pph, pfj, hfj) ->
    pph * pfj * hfj

  extraCharge = (ftc, ecc, ref, cab, ovc) ->
    isChecked(ftc) + isChecked(ecc) + isChecked(ref) + isChecked(cab) + isChecked(ovc)
  
  windowCleaningTotal = (cm, cpm, ftc, ecc, ref, cab, ovc) ->
    extraCleaningCharge = extraCharge(ftc, ecc, ref, cab, ovc)
    (cm * cpm) + extraCleaningCharge


  calculateCustomQuote = ->
    generalCPPJ = document.querySelector('#general-cleaning_people_per_job').value;
    generalCHFJ = document.querySelector('#general-cleaning_hours_for_job').value;
    generalCPPH = document.querySelector('#general-cleaning_price_per_hour').value;

    windowCM = document.querySelector('#window-cleaning_mensuration').value;
    windowCCPM = document.querySelector('#window-cleaning_cost_per_measurement').value;
    windowCD = document.querySelector('#window-cleaning_discount').value;

    firstTimeCharge = document.querySelector('#first_time_charge');
    extraCleanCharge = document.querySelector('#extra_clean_charge');
    refrigeratorCharge = document.querySelector('#refrigerator_charge');
    cabinetsCharge = document.querySelector('#cabinets_charge');
    ovenCleanCharge = document.querySelector('#oven_clean_charge');
    
    subTotal = generalCleaningTotal(generalCPPJ, generalCPPH, generalCHFJ)
    subTotal += windowCleaningTotal(windowCM, windowCCPM, firstTimeCharge, extraCleanCharge, refrigeratorCharge, cabinetsCharge, ovenCleanCharge)
    discount = (windowCD/100) * subTotal
    total = subTotal - discount

    sumTotal.innerHTML = total
    return


  # if document.location.pathname.endsWith('contract')

  calculateContractQuote = ->
    contractMV = document.querySelector('#monthly_visit').value;
    contractPPV = document.querySelector('#price_per_visit').value;
    contractCPM = document.querySelector('#cost_per_month');
    contractCM = document.querySelector('#contract_months').value;

    # calculate contract cost per month
    document.querySelector('#cost_per_month').value = contractMV * contractPPV

    return

  if document.location.pathname.includes('quotes')
    calculate.onclick = ->
      # calculateContractQuote()
      calculateCustomQuote()


  return
