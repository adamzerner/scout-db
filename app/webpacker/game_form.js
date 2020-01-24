$(document).on('turbolinks:load', function () {
  $(document).on('cocoon:before-insert', function (e, $gameForm) {
    setup($gameForm);
  });

  function setup($gameForm) {
    let $teamOneDropdown = $gameForm.find('select.team-one-dropdown');
    let $teamTwoDropdown = $gameForm.find('select.team-two-dropdown');

    selectInitialOptions($teamOneDropdown, $teamTwoDropdown);
    makeSureSelectedOptionsAreDisabled($teamOneDropdown, $teamTwoDropdown);
  }

  function selectInitialOptions($teamOneDropdown, $teamTwoDropdown) {
    $teamOneDropdown.find('option').eq(0).prop('selected', true);
    $teamTwoDropdown.find('option').eq(1).prop('selected', true);
  }

  function makeSureSelectedOptionsAreDisabled($teamOneDropdown, $teamTwoDropdown) {
    disableOptionThatIsSelectedInOtherDropdown($teamOneDropdown, $teamTwoDropdown.val());
    disableOptionThatIsSelectedInOtherDropdown($teamTwoDropdown, $teamOneDropdown.val());

    $teamOneDropdown.on('change', function (e) {
      disableOptionThatIsSelectedInOtherDropdown($teamOneDropdown, $teamTwoDropdown.val());
      disableOptionThatIsSelectedInOtherDropdown($teamTwoDropdown, $teamOneDropdown.val());
    });
    $teamTwoDropdown.on('change', function (e) {
      disableOptionThatIsSelectedInOtherDropdown($teamOneDropdown, $teamTwoDropdown.val());
      disableOptionThatIsSelectedInOtherDropdown($teamTwoDropdown, $teamOneDropdown.val());
    });
  }

  function disableOptionThatIsSelectedInOtherDropdown(currDropdown, optionThatIsSelectedInOtherDropdown) {
    currDropdown.find('option').each(function () {
      if ($(this).val() === optionThatIsSelectedInOtherDropdown) {
        $(this).prop('disabled', true);
      } else {
        $(this).prop('disabled', false);
      }
    });
  }
});
