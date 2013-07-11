class Ability
  include CanCan::Ability

  def initialize(usuario)
    # Define abilities for the passed in user here. For example:
    #
      
    if usuario.nil?
      can :read, :all
      cannot :read, [Reserva, Resultado, Comentario]
    else
      if usuario.admin?
          can :manage, :all
      else
          can :read, :all, usuario_id: usuario.id
          can :manage, Reserva, usuario_id: usuario.id
          can :manage, Comentario, autor: usuario.nome
          # cannot [:index], Reserva
      end  
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
