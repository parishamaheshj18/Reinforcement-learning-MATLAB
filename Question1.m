clc;
clear all;
close all;


set_states = ["00","01","10","11"];
set_actions = ["00","01","10","11"];
init_state="10";
%Q_matrix = zeros(length(set_states),length(set_actions));
reward_matrix = zeros(length(set_states),length(set_states),length(set_actions));
state_transition_matrix = zeros(length(set_states),length(set_states),length(set_actions));




%randomly select an action
for i=0:10000
            idx=randperm(length(set_actions),1);
            action= set_actions(idx);
            [next_state, reward] = Environment(action, init_state);            
            reward_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=reward;
            state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))+1;
            init_state=next_state;
end

state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2)
reward_matrix



% policy = ["00","01","10","11"];
% gamma = 0.99;
% learning_rate = 0.02;
% theta= 0.02;
% utility = 0;
% %utility=zeros(1,length(set_states));
% 
% for i=0:1000
% %     x= rand;
% %     if x<0.2
% %         idx=randperm(length(set_actions),1);
% %         action= set_actions(idx);
% %     else
%     for j=1:4
%         init_state=set_states(j);
%     action = policy(find(set_states==init_state));
% %     end
%     
%     [next_state, reward] = Environment(action, init_state);
%     state2d = state_transition_matrix(set_states==init_state,:,:);
%     state2d=[state2d(:,:,1);state2d(:,:,2);state2d(:,:,3);state2d(:,:,4)];
%     utility(find(set_states==next_state)) = reward + gamma.*sum(state2d*utility');
%     policy = improvepolicy(state_transition_matrix,reward_matrix,policy,init_state,set_states,set_actions,utility,gamma);
%     policy
%     end
% end
% 
% function [policy] = improvepolicy(transition_matrix,reward_matrix,policy,state,set_states,set_actions,utility,gamma)
% action=["00","01","10","11"];
% maxaction=action(1);
% maxreward=0;
%         for i=1:4
%         [next_state,reward]= Environment(state,action(i));
%         reward_value = reward+gamma.*(transition_matrix(find(set_states==state),:,find(set_actions==action(i)))*utility');
%         if reward_value>maxreward
%             maxaction=action(i);
%             maxreward=reward;
%         end
%         end
% policy(find(set_actions==next_state))=maxaction;
% end


function [next_state, reward ]= Environment(action, state)

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
    
    reward = (10*summ(action)) - (50* coll(next_state,action));
    
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





