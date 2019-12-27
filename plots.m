
clc;
clear all;
close all;
set_states = ["00","01","10","11"];
set_actions = ["00","01","10","11"];
init_state="10";
%Q_matrix = zeros(length(set_states),length(set_actions));
reward_matrix = zeros(length(set_states),length(set_states),length(set_actions));
state_transition_matrix = zeros(length(set_states),length(set_states),length(set_actions));

policy=["01","01","01","00"];
plotreward=zeros(1,10000);
plotcollisions=zeros(1,10000);
plotcumulativecoll=zeros(1,10000);
total_reward=0;
total_collisions=0;
%randomly select an action
for i=1:10000
            
            action= policy(set_states==init_state);
            [next_state, reward,collisions] = Environment(action, init_state);
            total_reward=total_reward+reward;
            total_collisions=total_collisions+collisions;
            plotcollisions(1,i)=total_collisions;
            plotcumulativecoll(1,i)=collisions;
            plotreward(1,i)=total_reward;
            reward_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=reward;
            state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))+1;
            
            init_state=next_state;
            
end



%%%%%%
%%%%%%

%state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2);
state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2);

%%%%%%%%%


set_states = ["00","01","10","11"];
set_actions = ["00","01","10","11"];
init_state="10";
%Q_matrix = zeros(length(set_states),length(set_actions));
reward_matrix = zeros(length(set_states),length(set_states),length(set_actions));
state_transition_matrix = zeros(length(set_states),length(set_states),length(set_actions));

policy=["01","01","01","00"];
plotreward2=zeros(1,10000);
plotcollisions2=zeros(1,10000);
total_reward2=0;
plotcumulativecoll2=zeros(1,10000);
 total_collisions2=0;
%randomly select an action
for i=1:10000
            
            action= policy(set_states==init_state);
            [next_state, reward,collisions] = Environment2(action, init_state);
            total_reward2=total_reward+reward;
            total_collisions2=total_collisions2+collisions;
            plotcollisions2(1,i)=total_collisions2;
            plotcumulativecoll2(1,i)=collisions;
            plotreward2(1,i)=total_reward;
            reward_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=reward;
            state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))+1;
            
            init_state=next_state;
            
end


%state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2);
state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2);

X=linspace(1,10000,10000);
figure()
plot(X,plotcollisions,'-r',X,plotcollisions2,'-b');
xlabel("Steps")
ylabel("Collision per step")
title("Total number of Collisions")
legend('Non-reactive System','Reactive System')
figure()
plot(X,plotreward,X,plotreward2);
xlabel("Steps")
ylabel("Total reward")
title("Total Reward")
legend('Non-reactive System','Reactive System')
figure;
stem(plotcumulativecoll,'markerfacecolor',[0 0 1]);
set(gca,'ylim',[-0.5 1.5])
xlabel("Steps")
ylabel("Collisions per step")
title("Originial System: Collisions")
stem(plotcumulativecoll2,'markerfacecolor',[0 0 1]);
set(gca,'ylim',[-0.5 1.5])
xlabel("Steps")
ylabel("Collisions per step")
title("Reactive system: Collisions")
%%%%%%%%%
function [next_state, reward,collisions ]= Environment2(action, state)

        if action =="00"
            next_state="11";
        elseif action=="01"
            next_state="10";
        elseif action=="10"
            next_state="01";
        elseif action=="11"
            next_state="00";
              
        end
   
    collisions=coll(next_state,action);
    reward = (10*summ(action)) - (50* collisions);
    
end





function [next_state, reward,collisions ]= Environment(action, state)

    if state=="00"
        if action =="00"
            next_state="00";
        elseif action=="01"
            next_state="10";
        elseif action=="10"
            next_state="01";
        elseif action=="11"
            x=rand;
                if x<0.2
                    next_state="00";
                else
                    next_state="11";
                end
        end
    end
    
    if state=="01"
            if action =="00"
                next_state="01";
            elseif action=="01"
                x=rand;
                    if x<0.2
                        next_state="11";
                    else
                        next_state="10";
                    end
            elseif action=="10"
                x=rand;
                    if x<0.2
                        next_state="11";
                    else
                        next_state="01";
                    end
            elseif action=="11"
                x=rand;
                    if x<0.2
                        next_state="00";
                    else
                        next_state="11";
                    end
            end
    end
    
    if state=="10"
        if action =="00"
            next_state="10";
        elseif action=="01"
            x=rand;
                if x<0.2
                    next_state="11";
                else
                    next_state="10";
                end
        elseif action=="10"
            x=rand;
                if x<0.2
                    next_state="11";
                else
                    next_state="01";
                end
        elseif action=="11"
            x=rand;
                if x<0.2
                    next_state="00";
                else
                    next_state="11";
                end
        end
     end
    if state=="11"
                x=rand;
                if x<0.2
                    next_state="00";
                else
                    next_state="11";
                end
    end
    collisions=coll(next_state,action)
    reward = (10*summ(action)) - (50* collisions);
    
end

function [summation] = summ(action)
           if action=="00"
               summation=0;
           elseif action=="01"
               summation=1;
           elseif action=="10"
               summation=1;
           elseif action=="11"
               summation=2;
           end
end

function [collision]= coll(s, a)
        
    if a=="00" && s=="00" 
        collision = 0;
    elseif a=="00" && s=="01"
        collision = 0;
    elseif a=="00" && s=="10"
        collision = 0;
    elseif a=="00" && s=="11"  
        collision = 0;
    elseif a=="01" && s=="00" 
        collision = 0 ;
    elseif a=="01" && s=="01"  
        collision = 1 ;
    elseif a=="01" && s=="10"  
        collision = 0;
    elseif a=="01" && s=="11"  
        collision = 1;
    elseif a=="10" && s=="00"  
        collision = 0 ;
    elseif a=="10" && s=="01"  
        collision = 0 ;
    elseif a=="10" && s=="10"  
        collision = 1;
    elseif a=="10" && s=="11"  
        collision = 1 ;
    elseif a=="11" && s=="00"  
        collision = 0 ;
    elseif a=="11" && s=="01"  
        collision = 1;
    elseif a=="11" && s=="10"  
        collision = 1;
    elseif a=="11" && s=="11"  
        collision = 2;
    end
end


%%%% main code for Agent system A



