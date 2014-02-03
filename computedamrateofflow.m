%% Dam spillway rate of flow
% Q = computedamrateofflow(B,H,V).  Calculate the volume rate of flow over
% the spillway of a dam by the simple hydraulic formula
%  $Q = C \sqrt{2g} B (H + V^2/{2g})^{3/2}$.
%
% B spillway width, m
% H depth of water passing over spillway, m
% V upstream velocity of water, m/s
%
function Q = computedamrateofflow(B,H,V)

