# frozen_string_literal: true

RSpec.describe EacRedmineUsability::Undeletable do
  fixtures :issues, :issue_statuses, :projects, :users, :wikis, :wiki_pages

  around do |example|
    described_class.on_allow_destroy(false, &example)
  end

  [Issue, Project, User, Wiki, WikiPage].each do |model|
    context "when model is #{model}" do
      let(:record) { model.first }

      it { expect(record).to be_present }
      it { expect(record.errors[:base]).to be_blank }

      context 'when record is called for detroy' do
        let(:record_id) { record.id }
        let(:destroy_result) { record.destroy }

        before do
          record_id
          destroy_result
        end

        it { expect(destroy_result).to be_falsy }
        it { expect(record.errors[:base]).to be_present }
        it { expect(model.find(record_id)).to be_present }
      end
    end
  end
end
