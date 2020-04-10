class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else
      @events = StaffEvent.order(occurred_at: :desc)
    end
    @events = @events.includes(:member) #N+1対策
    @events = @events.page(params[:page])
  end
end
