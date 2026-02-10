class DemoResetJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "[DemoReset] Starting nightly demo reset..."

    ActiveRecord::Base.transaction do
      clear_helpdesk_data if defined?(Panda::Helpdesk)
      clear_cms_pro_data if defined?(Panda::CMS::Pro)
      clear_cms_data
    end

    Panda::CMS::SanctuaryDemo.generate!

    Rails.logger.info "[DemoReset] Demo reset complete."
  end

  private

  def clear_helpdesk_data
    Panda::Helpdesk::Message.delete_all
    Panda::Helpdesk::TicketEvent.delete_all
    Panda::Helpdesk::Ticket.delete_all
    Panda::Helpdesk::DepartmentAgent.delete_all
    Panda::Helpdesk::DepartmentField.delete_all
    Panda::Helpdesk::DepartmentVisibility.delete_all
    Panda::Helpdesk::Department.delete_all
    Panda::Helpdesk::CannedResponse.delete_all
    Panda::Helpdesk::AuditLog.delete_all
  end

  def clear_cms_pro_data
    Panda::CMS::Pro::BrokenLink.delete_all if defined?(Panda::CMS::Pro::BrokenLink)
    Panda::CMS::Pro::LinkCheck.delete_all if defined?(Panda::CMS::Pro::LinkCheck)
    Panda::CMS::Pro::ContentComment.delete_all if defined?(Panda::CMS::Pro::ContentComment)
    Panda::CMS::Pro::ContentSuggestion.delete_all if defined?(Panda::CMS::Pro::ContentSuggestion)
    Panda::CMS::Pro::ContentChange.delete_all if defined?(Panda::CMS::Pro::ContentChange)
    Panda::CMS::Pro::ContentVersion.delete_all if defined?(Panda::CMS::Pro::ContentVersion)
    Panda::CMS::CollectionItem.delete_all if defined?(Panda::CMS::CollectionItem)
    Panda::CMS::CollectionField.delete_all if defined?(Panda::CMS::CollectionField)
    Panda::CMS::Collection.delete_all if defined?(Panda::CMS::Collection)
  end

  def clear_cms_data
    Panda::CMS::FormSubmission.delete_all
    Panda::CMS::FormField.delete_all
    Panda::CMS::Form.delete_all
    Panda::CMS::PostTag.delete_all if defined?(Panda::CMS::PostTag)
    Panda::CMS::Post.delete_all
    Panda::CMS::BlockContent.delete_all
    Panda::CMS::Block.delete_all
    Panda::CMS::MenuItem.delete_all
    Panda::CMS::Menu.delete_all
    Panda::CMS::Redirect.delete_all
    Panda::CMS::Page.delete_all
    Panda::CMS::Template.delete_all

    # Purge Active Storage attachments from the demo cycle
    ActiveStorage::Attachment.delete_all
    ActiveStorage::Blob.delete_all
  end
end
