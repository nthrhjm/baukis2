class Staff::SessionsController < Staff::Base
  def new
    # current_staff_member メソッドはStaff/Base.rbで定義
    # ログイン状態しているか？
    if current_staff_member
      redirect_to :staff_root #ログインしていたら職員トップページへ
    else
      @form = Staff::LoginForm.new #form objectを生成してインスタンス変数へセット
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)
    if @form.email.present?
      staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログインしました。"
        redirect_to :staff_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました。"
    redirect_to :staff_root
  end
end
