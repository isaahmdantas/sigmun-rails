class Admin::AuditsController < AdminController 
    before_action :set_audit, only: [:show]

    def show;end

    private 
        def set_audit
            @id = params.try(:[], :id)
            @auditable_type = params.try(:[], :auditable_type)
            @auditable_id = params.try(:[], :auditable_id)
            @audit = @auditable_type.try(:classify).try(:safe_constantize).try(:find, @auditable_id).try(:audits).try(:find, @id)
        end
      
end