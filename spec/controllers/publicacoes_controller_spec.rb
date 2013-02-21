require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PublicacoesController do

  # This should return the minimal set of attributes required to create a valid
  # Publicacao. As you add validations to Publicacao, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PublicacoesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all publicacoes as @publicacoes" do
      publicacao = Publicacao.create! valid_attributes
      get :index, {}, valid_session
      assigns(:publicacoes).should eq([publicacao])
    end
  end

  describe "GET show" do
    it "assigns the requested publicacao as @publicacao" do
      publicacao = Publicacao.create! valid_attributes
      get :show, {:id => publicacao.to_param}, valid_session
      assigns(:publicacao).should eq(publicacao)
    end
  end

  describe "GET new" do
    it "assigns a new publicacao as @publicacao" do
      get :new, {}, valid_session
      assigns(:publicacao).should be_a_new(Publicacao)
    end
  end

  describe "GET edit" do
    it "assigns the requested publicacao as @publicacao" do
      publicacao = Publicacao.create! valid_attributes
      get :edit, {:id => publicacao.to_param}, valid_session
      assigns(:publicacao).should eq(publicacao)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Publicacao" do
        expect {
          post :create, {:publicacao => valid_attributes}, valid_session
        }.to change(Publicacao, :count).by(1)
      end

      it "assigns a newly created publicacao as @publicacao" do
        post :create, {:publicacao => valid_attributes}, valid_session
        assigns(:publicacao).should be_a(Publicacao)
        assigns(:publicacao).should be_persisted
      end

      it "redirects to the created publicacao" do
        post :create, {:publicacao => valid_attributes}, valid_session
        response.should redirect_to(Publicacao.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved publicacao as @publicacao" do
        # Trigger the behavior that occurs when invalid params are submitted
        Publicacao.any_instance.stub(:save).and_return(false)
        post :create, {:publicacao => {}}, valid_session
        assigns(:publicacao).should be_a_new(Publicacao)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Publicacao.any_instance.stub(:save).and_return(false)
        post :create, {:publicacao => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested publicacao" do
        publicacao = Publicacao.create! valid_attributes
        # Assuming there are no other publicacoes in the database, this
        # specifies that the Publicacao created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Publicacao.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => publicacao.to_param, :publicacao => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested publicacao as @publicacao" do
        publicacao = Publicacao.create! valid_attributes
        put :update, {:id => publicacao.to_param, :publicacao => valid_attributes}, valid_session
        assigns(:publicacao).should eq(publicacao)
      end

      it "redirects to the publicacao" do
        publicacao = Publicacao.create! valid_attributes
        put :update, {:id => publicacao.to_param, :publicacao => valid_attributes}, valid_session
        response.should redirect_to(publicacao)
      end
    end

    describe "with invalid params" do
      it "assigns the publicacao as @publicacao" do
        publicacao = Publicacao.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Publicacao.any_instance.stub(:save).and_return(false)
        put :update, {:id => publicacao.to_param, :publicacao => {}}, valid_session
        assigns(:publicacao).should eq(publicacao)
      end

      it "re-renders the 'edit' template" do
        publicacao = Publicacao.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Publicacao.any_instance.stub(:save).and_return(false)
        put :update, {:id => publicacao.to_param, :publicacao => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested publicacao" do
      publicacao = Publicacao.create! valid_attributes
      expect {
        delete :destroy, {:id => publicacao.to_param}, valid_session
      }.to change(Publicacao, :count).by(-1)
    end

    it "redirects to the publicacoes list" do
      publicacao = Publicacao.create! valid_attributes
      delete :destroy, {:id => publicacao.to_param}, valid_session
      response.should redirect_to(publicacoes_url)
    end
  end

end
