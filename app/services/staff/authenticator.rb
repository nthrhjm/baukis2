class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member && #@staff_memberが存在する
        !@staff_member.suspended? && #@staff_memberがsuspend状態ではない
        @staff_member.hashed_password && #パスワードが設定済みである
        @staff_member.start_date <= Date.today && #開始日が今日以前である
        (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) && #終了日が設定されている または、終了日が今日より後である
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password #パスワードが正しい
        #上の == は比較演算子ではなく、BCrypt::Password オブジェクトのインスタンスメソッド。
        # 引数に渡されたraw_password(平文のパスワード)をハッシュ関数で計算して、自分自身の保持しているハッシュ値と
        # 同じであればtrueを返す。
  end
end