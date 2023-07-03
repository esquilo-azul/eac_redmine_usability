class IssueDoneRatioAlternativeInput {
  constructor(originalInputId, alternativeInputId, changerControlId, hiddenContentId) {
    this.originalInputId = originalInputId;
    this.alternativeInputId = alternativeInputId;
    this.changerControlId = changerControlId;
    this.hiddenContentId = hiddenContentId;
    this.initialValue = this.alternativeInput().value;
    this.originalInputSelected = true
  }

  alternativeInput() {
    return $('#' + this.alternativeInputId);
  }

  changeInput() {
    if (this.originalInputSelected) {
      this.useAlternativeInput();
    } else {
      this.useOriginalInput();
    }
  }

  changerControl() {
    return $('#' + this.changerControlId);
  }

  hiddenContent() {
    return $('#' + this.hiddenContentId);
  }

  init() {
    if (this.originalInput().length > 0) {
      this.initOriginalInput();
      this.initAlternativeInput();
      this.initChangerControl();
      this.initContent();
    }
  }

  initAlternativeInput() {
    var THIS = this;
    this.alternativeInput().change(function() {
      THIS.onAlternativeValueChanged();
    });
    this.alternativeInput().attr('name', this.originalInput().attr('name'));
  }

  initChangerControl() {
    var THIS = this;
    this.changerControl().insertAfter(this.originalInput());
    this.changerControl().click(function() {
      THIS.changeInput();
      return false;
    });
  }

  initOriginalInput() {
    var THIS = this;
    this.onAlternativeValueChanged()
    this.originalInput().change(function() {
      THIS.onOriginalValueChanged();
    });
  }

  initContent() {
    $('body').append(this.hiddenContent());
    if (this.originalInput().val() != this.alternativeInput().val()) {
      this.useAlternativeInput();
    }
  }

  onAlternativeValueChanged() {
    this.originalInput().val(Math.round(this.alternativeInput().val() / 10) * 10);
  }

  onOriginalValueChanged() {
    this.alternativeInput().val(this.originalInput().val());
  }

  originalInput() {
    return $('#' + this.originalInputId);
  }

  useAlternativeInput() {
    if (this.originalInputSelected) {
      this.alternativeInput().insertBefore(this.changerControl());
      this.originalInput().appendTo(this.hiddenContent());
      this.originalInputSelected = false;
    }
  }

  useOriginalInput() {
    if (!this.originalInputSelected) {
      this.originalInput().insertBefore(this.changerControl());
      this.alternativeInput().appendTo(this.hiddenContent());
      this.originalInputSelected = true;
    }
  }
}
