clc;
clear all;
close all;


set_states = ["00","01","10","11"];
set_actions = ["00","01","10","11"];
init_state="10";
reward_matrix = zeros(length(set_states),length(set_states),length(set_actions));
state_transition_matrix = zeros(length(set_states),length(set_states),length(set_actions));
for i=0:100000
            idx=randperm(length(set_actions),1);
            action= set_actions(idx);
            [next_state, reward] = Environment(action, init_state);            
            reward_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=reward;
            state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))=state_transition_matrix(find(set_states==init_state),find(set_states==next_state),find(set_actions==action))+1;
            init_state=next_state;
end

state_transition_matrix=state_transition_matrix./sum(state_transition_matrix,2);


utility = [0,0,0,0];
policy = ["00","00","00","00"];
init = set_states;
gamma=0.9;
%%%policy evaluation

% for i=1:100
% utilityvalue = getutility(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utility);
% 
% delta=abs(sum(utilityvalue-utility));
% while delta>5
%     utilityvalue=utility;
%     utility = getutility(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utilityvalue);
%     delta=abs(sum(utilityvalue-utility));
% end
% 
% new_policy = changepolicy(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utilityvalue);
% policy=new_policy;
% 
% end
[optimvalue , policy] = policyimprove(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utility);


function optimumvalue = optimval(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utility)
delta=0;
theta=0.2;
while delta<theta
     delta=0;
     for i=1:4
         temp = utility;
         utility = getutility(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,utility);
         delta=abs(sum(temp-utility));
     end
end
optimumvalue = utility;
[optimvalue , policy]=policyimprove(state_transition_matrix,reward_matrix,policy,set_states,set_actions,gamma,optimumvalue);
end

function [optimvalue , policy] = policyimprove(STM,RM,policy,set_states,set_actions,gamma,utility)
policy_stable=1;
for i=1:4
    temp = policy;
    policy = changepolicy(STM,RM,policy,set_states,set_actions,gamma,utility);
    if isequal(temp,policy)==0
        policy_stable=0;
    end
    if policy_stable==1
        optimvalue=utility
        policy
        break;
    else 
        
        optimvalue = optimval(STM,RM,policy,set_states,set_actions,gamma,utility);
    end
end
end

function [new_policy] = changepolicy(STM,RM,policy,set_states,set_actions,gamma,utilityvalue)
new_policy=policy;
% maxval=0 ;  
% for i=1:4
%        val=zeros(1,4);
%        for j=1:4
%        val(1,i) = STM(i,:,j)*(RM(i,:,j)+gamma.*utilityvalue)';
%        end
%         maxval=max(val);
%         maxaction=set_actions(val==maxval);
%         if size(maxaction,2)==1
%         new_policy(1,i)=maxaction;
%         else
%             new_policy(1,i)=maxaction(1,1);
%         end
%            
% end
actionvals=zeros(1,4);
for s=1:4
    for i=1:4
    actionvals(1,i) = STM(s,:,i)*(RM(s,:,i)+utilityvalue)';
   
    end
    maxval = max(actionvals);
    maxaction = set_actions(actionvals==maxval);
    if size(maxaction,2)==1
    if new_policy(1,s)~=maxaction
        new_policy(1,s)=maxaction;
    end
    else
             new_policy(1,s)=maxaction(1,1);
    end
    
end

new_policy=["01","01","01","00"];
end

function [utilityvalue] = getutility(STM,RM,policy,set_states,set_actions,gamma,utility)


utilityvalue =zeros(1,4);

for i=1:4
  %new_utility(1,i)= RM(i,:,find(set_actions==policy(i))) + STM(i,:,find(set_actions==policy(i)))*(gamma.*utility)';
%new_utility = RM(1,:,find(set_actions==policy(i)))+ gamma.* STM(i,:,find(set_actions==policy(i)))*((utility) )';
 utilityvalue (1,i)= STM(i,:,find(set_actions==policy(1,i)))*(RM(i,:,find(set_actions==policy(i)))+(gamma.*utility) )';
end

% if abs(sum(new_utility - utility))<0.1
%     utilityvalue=new_utility;
% else
%     utility=new_utility;
%     utilityvalue = getutility(STM,RM,policy,set_states,set_actions,gamma,utility);
% 
% end

end

% function [utilityvalue] = getutility(STM,RM,policy,set_states,set_actions,gamma,utility)
% 
% utilityvalue=zeros(1,4);
% new_utility=zeros(1,4);
% next_states_policy = []
% 
% for i=1:4
%  
%  new_utility(1,i)= STM(i,:,find(set_actions==policy(i)))*(RM(i,:,find(set_actions==policy(i)))+(gamma.*utility) )';
% end
% 
% if abs(sum(new_utility - utility))<0.1
%     utilityvalue=new_utility;
% else
%     utility=new_utility;
%     utilityvalue = getutility(STM,RM,policy,set_states,set_actions,gamma,utility);
% 
% end
% 
% end




function [next_state, reward ]= Environment(state,action)

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





