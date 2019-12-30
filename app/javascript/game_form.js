$(document).on('turbolinks:load', function () {
  let $gameForm = $('.game-form');

  if ($gameForm.length) {
    let $teamOneDropdown = $gameForm.find('select#tournament_team_one_id');
    let $teamTwoDropdown = $gameForm.find('select#tournament_team_two_id');

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

    $teamOneDropdown.on('change', function () {
      disableOptionThatIsSelectedInOtherDropdown($teamTwoDropdown, $(this).val());
    });
    $teamTwoDropdown.on('change', function () {
      disableOptionThatIsSelectedInOtherDropdown($teamOneDropdown, $(this).val());
    });
  }

  function disableOptionThatIsSelectedInOtherDropdown(currDropdown, optionThatIsSelectedInOtherDropdown) {
    currDropdown.find('option').each(function () {
      if ($(this).val() === optionThatIsSelectedInOtherDropdown) {
        $(this).prop('disabled', true);
      } else {
        $(this).removeProp('disabled')
      }
    });
  }
});
