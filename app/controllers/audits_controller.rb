class AuditsController < ApplicationController 

    def show 
        @audit = params[:auditable_type].classify.safe_constantize.find(params[:auditable_id]).audits.find(params[:audit_id])
    end
      
end