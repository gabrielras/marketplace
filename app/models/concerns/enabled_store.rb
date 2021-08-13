module EnabledStore
  private

  def profile_is_complete?(current_store)
    current_store.profile.present?
  end

  def shipping_is_complete?(current_store)
    current_store.shipping.present?
  end
end
