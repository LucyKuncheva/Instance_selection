function [v,v_lab] = edit_wilson_hart(b,l,~)
[R,R_lab] = edit_wilson(b,l);
[v,v_lab] = edit_hart(R,R_lab);