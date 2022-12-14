import matplotlib 
from matplotlib import pyplot as plt
import numpy as np

ftra1 = [
[0.070000,		 17.465937,		  4.531670],
[0.080000,		 17.826094,		  5.212041],
[0.090000,		 18.367500,		  5.934484],
[0.100000,		 19.275781,		  6.676646],
[0.110000,		 20.313750,		  7.415763],
[0.120000,		 21.974375,		  8.180151],
[0.130000,		 24.772656,		  8.957926],
[0.140000,		 38.233438,		  9.759313],
[0.150000,		130.687031,		 10.451135],
[0.160000,		205.756406,		 10.656586],
[0.170000,		297.935938,		  9.927032],
[0.180000,		377.183281,		 10.714916],]

ftra2 = [[0.070000,		 17.385625,		  4.531670],
[0.080000,		 17.750469,		  5.212041],
[0.090000,		 18.369688,		  5.934484],
[0.100000,		 19.311406,		  6.676646],
[0.110000,		 20.386406,		  7.415763],
[0.120000,		 21.600938,		  8.180151],
[0.130000,		 25.101875,		  8.957926],
[0.140000,		 34.647656,		  9.759313],
[0.150000,		 93.292812,		  9.986113],
[0.160000,		165.623594,		 10.310461],
[0.170000,		264.517031,		 10.548122],
[0.180000,		360.232188,		 10.560767],]

ftra3 = [[0.070000,		 17.458594,		  4.531670],
[0.080000,		 17.789844,		  5.212041],
[0.090000,		 18.445000,		  5.934484],
[0.100000,		 19.239062,		  6.676646],
[0.110000,		 20.129219,		  7.415763],
[0.120000,		 22.120000,		  8.180151],
[0.130000,		 24.767344,		  8.957926],
[0.140000,		 31.860469,		  9.759313],
[0.150000,		 63.659375,		 10.605267],
[0.160000,		158.483906,		 10.637283],
[0.170000,		248.125469,		 10.420228],
[0.180000,		368.340781,		 10.457338],]

ftra4 = [[0.070000,		 17.397813,		  4.531670],
[0.080000,		 17.723281,		  5.212041],
[0.090000,		 18.345938,		  5.934484],
[0.100000,		 19.238437,		  6.676646],
[0.110000,		 20.118594,		  7.415763],
[0.120000,		 21.525000,		  8.180151],
[0.130000,		 24.567812,		  8.957926],
[0.140000,		 31.634687,		  9.759313],
[0.150000,		 81.768594,		 10.497840],
[0.160000,		155.972187,		 10.298407],
[0.170000,		247.611406,		 10.692156],
[0.180000,		364.957344,		 10.109310],]

ftra5 = [[0.070000,		 17.391094,		  4.531670],
[0.080000,		 17.789062,		  5.212041],
[0.090000,		 18.325156,		  5.934484],
[0.100000,		 19.235781,		  6.676646],
[0.110000,		 20.316094,		  7.415763],
[0.120000,		 21.868750,		  8.180151],
[0.130000,		 24.500937,		  8.957926],
[0.140000,		 33.570625,		  9.759313],
[0.150000,		 70.332188,		 10.532357],
[0.160000,		153.572031,		 10.643709],
[0.170000,		227.664062,		 10.675958],
[0.180000,		324.521250,		 10.621251],]

ftra6 = [[0.070000,		 17.420938,		  4.531670],
[0.080000,		 17.789844,		  5.212041],
[0.090000,		 18.356875,		  5.934484],
[0.100000,		 19.254531,		  6.676646],
[0.110000,		 20.166719,		  7.415763],
[0.120000,		 21.698750,		  8.180151],
[0.130000,		 24.537344,		  8.957926],
[0.140000,		 28.341562,		  9.759313],
[0.150000,		 57.411094,		 10.605267],
[0.160000,		178.237969,		 10.383380],
[0.170000,		260.955625,		 10.692156],
[0.180000,		382.259687,		 10.274384],]

ftra7 = [[0.070000,		 17.379375,		  4.531670],
[0.080000,		 17.775156,		  5.212041],
[0.090000,		 18.435625,		  5.934484],
[0.100000,		 19.324219,		  6.676646],
[0.110000,		 20.210938,		  7.415763],
[0.120000,		 21.664062,		  8.180151],
[0.130000,		 23.939062,		  8.957926],
[0.140000,		 29.302344,		  9.759313],
[0.150000,		 57.395938,		 10.605267],
[0.160000,		162.406094,		 10.544965],
[0.170000,		249.962031,		 10.672725],
[0.180000,		380.592188,		 10.170587],]

ftra8 = [[0.070000,		 17.405156,		  4.531670],
[0.080000,		 17.770312,		  5.212041],
[0.090000,		 18.353750,		  5.934484],
[0.100000,		 19.182969,		  6.676646],
[0.110000,		 20.048281,		  7.415763],
[0.120000,		 21.535625,		  8.180151],
[0.130000,		 24.146719,		  8.957926],
[0.140000,		 31.221563,		  9.759313],
[0.150000,		 76.975000,		 10.605267],
[0.160000,		154.941094,		 10.522921],
[0.170000,		275.689687,		 10.754158],
[0.180000,		382.676875,		 10.538657],]

comm1 = [
[0.070000,		 17.444063,		  4.531670],
[0.080000,		 17.782187,		  5.212041],
[0.090000,		 18.420156,		  5.934484],
[0.100000,		 19.457656,		  6.676646],
[0.110000,		 20.369219,		  7.415763],
[0.120000,		 22.183125,		  8.180151],
[0.130000,		 25.152812,		  8.957926],
[0.140000,		 32.776875,		  9.759313],
[0.150000,		 88.635781,		 10.605267],
[0.160000,		180.196406,		 10.573443],
[0.170000,		244.356875,		 10.576617],
[0.180000,		325.141563,		 10.401771],]

comm2 = [
[0.070000,		 17.453594,		  4.531670],
[0.080000,		 17.769531,		  5.212041],
[0.090000,		 18.468594,		  5.934484],
[0.100000,		 19.361406,		  6.676646],
[0.110000,		 20.358281,		  7.415763],
[0.120000,		 21.982969,		  8.180151],
[0.130000,		 24.577500,		  8.957926],
[0.140000,		 31.787656,		  9.759313],
[0.150000,		 50.587812,		 10.605267],
[0.160000,		124.098281,		 10.803618],
[0.170000,		250.878125,		 10.494713],
[0.180000,		337.768125,		 10.226672],]

comm3 = [
[0.070000,		 17.435312,		  4.531670],
[0.080000,		 17.846719,		  5.212041],
[0.090000,		 18.357813,		  5.934484],
[0.100000,		 19.260781,		  6.676646],
[0.110000,		 20.440156,		  7.415763],
[0.120000,		 21.552969,		  8.180151],
[0.130000,		 24.984375,		  8.957926],
[0.140000,		 30.015469,		  9.759313],
[0.150000,		 73.084531,		 10.429481],
[0.160000,		131.317344,		 10.682431],
[0.170000,		261.632031,		 10.235585],
[0.180000,		334.483750,		 10.407916],]

comm4 = [
[0.070000,		 17.476406,		  4.531670],
[0.080000,		 17.869219,		  5.212041],
[0.090000,		 18.413750,		  5.934484],
[0.100000,		 19.368437,		  6.676646],
[0.110000,		 20.287813,		  7.415763],
[0.120000,		 21.658750,		  8.180151],
[0.130000,		 24.944219,		  8.957926],
[0.140000,		 28.510000,		  9.759313],
[0.150000,		 55.124063,		 10.605267],
[0.160000,		160.182187,		 10.734501],
[0.170000,		288.403437,		 10.065991],
[0.180000,		375.304531,		 10.410991],]

a1 = np.array(ftra1)
a2 = np.array(ftra2)
a3 = np.array(ftra3)
a4 = np.array(ftra4)
a5 = np.array(ftra5)
a6 = np.array(ftra6)
a7 = np.array(ftra7)
a8 = np.array(ftra8)
b1 = np.array(comm1)
b2 = np.array(comm2)
b3 = np.array(comm3)
b4 = np.array(comm4)

BOUND = 12
WIDTH = 2
MSIZE = 8

plt.figure(figsize=(5.68,6),dpi=180)
plt.plot(a1[:BOUND,0],a1[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 5")
plt.plot(a2[:BOUND,0],a2[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 6")
plt.plot(a3[:BOUND,0],a3[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 7")
plt.plot(a4[:BOUND,0],a4[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 8")
plt.plot(a5[:BOUND,0],a5[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 9")
plt.plot(a6[:BOUND,0],a6[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 10")
plt.plot(a7[:BOUND,0],a7[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 11")
plt.plot(a8[:BOUND,0],a8[:BOUND,2],'o-', markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="FTRA 12")

plt.plot(b1[:BOUND,0],b1[:BOUND,2],'^-' ,markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="MUTUAL 1")
plt.plot(b2[:BOUND,0],b2[:BOUND,2],'^-' ,markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="MUTUAL 2")
plt.plot(b3[:BOUND,0],b3[:BOUND,2],'^-' ,markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="MUTUAL 3")
plt.plot(b4[:BOUND,0],b4[:BOUND,2],'^-' ,markerfacecolor='white',markeredgewidth=WIDTH,linewidth=WIDTH,markersize=MSIZE,label="MUTUAL 4")

plt.subplots_adjust(left=0.13, right=0.95, top=0.95, bottom=0.5)#????????????????????????
plt.legend(bbox_to_anchor=(0, -0.7), loc=3, borderaxespad=0,ncol=3,fontsize=14,shadow=True,frameon=False,columnspacing=1)

plt.xlabel("Injection rate (flits/cycle/node)",fontsize=14)
plt.ylabel("Throughput (flits/cycle)",fontsize=14)

# global
plt.yticks([4,6,8,10,12],fontsize=12)
plt.xticks([0.08,0.10,0.12,0.14,0.16,0.18],fontsize=12)

plt.xlim([0.07,0.18])
plt.ylim([3,12])

# partial
# plt.yticks([9.6,9.8,10.0,10.2,10.4,10.6,10.8,11.0],fontsize=12)
# plt.xticks([0.14,0.15,0.16,0.17,0.18],fontsize=12)

# plt.xlim([0.14,0.18])
# plt.ylim([9.6,11])

plt.grid(axis = "y")
# plt.plot(b[:,0],b[:,2])
plt.show()