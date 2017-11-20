import os
import csv
import numpy as np
import matplotlib.pyplot as plt

workingdir = 'matlab_output_revised_2017.11.01_10_17_34'

maxcompArr = np.array([1,2,3,4,5,6,8,10,12])

v1 = np.zeros(shape=(16,5))
stabw_mean = np.zeros(shape=(maxcompArr.size,5))
meand_mean = np.zeros(shape=(maxcompArr.size,5))
medid_mean = np.zeros(shape=(maxcompArr.size,5))
stabw_mode = np.zeros(shape=(maxcompArr.size,5))
meand_mode = np.zeros(shape=(maxcompArr.size,5))
medid_mode = np.zeros(shape=(maxcompArr.size,5))
stabw_medi = np.zeros(shape=(maxcompArr.size,5))
meand_medi = np.zeros(shape=(maxcompArr.size,5))
medid_medi = np.zeros(shape=(maxcompArr.size,5))
stabw_base = np.zeros(shape=(maxcompArr.size,5))
meand_base = np.zeros(shape=(maxcompArr.size,5))
medid_base = np.zeros(shape=(maxcompArr.size,5))
#print v1

#===============================================================================
# functions

def CreatePath(path):
    if (os.path.exists(workingdir + '/plots/' + path)==False):
        os.makedirs(workingdir + '/plots/' + path)
        print path, " path created"

#===============================================================================
# main

for maxcomp in enumerate(maxcompArr):
    print 'maxcomp', maxcomp
    with open(workingdir + '/maxcomp' + str(maxcomp[1]) + '/output_m3.csv', 'rb') as csvfile:
        output_m3 = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in enumerate(output_m3):
            if (row[0] == 15):
                print 'row[1][0]', row[1][0]
            else:
                for j in range(5):
                    v1[row[0]][j]=row[1][j]
        print 'v1'
        print v1
        stabw_mean[maxcomp[0]]=v1[3]
        meand_mean[maxcomp[0]]=v1[4]
        medid_mean[maxcomp[0]]=v1[5]
        stabw_mode[maxcomp[0]]=v1[6]
        meand_mode[maxcomp[0]]=v1[7]
        medid_mode[maxcomp[0]]=v1[8]
        stabw_medi[maxcomp[0]]=v1[9]
        meand_medi[maxcomp[0]]=v1[10]
        medid_medi[maxcomp[0]]=v1[11]
        stabw_base[maxcomp[0]]=v1[12]
        meand_base[maxcomp[0]]=v1[13]
        medid_base[maxcomp[0]]=v1[14]

# Create Paths
if (os.path.exists(workingdir + '/plots')==False):
    os.makedirs(workingdir + '/plots')
    print "plots path created"

CreatePath('stabw')
CreatePath('meand')
CreatePath('medid')

#===============================================================================
# Print Plots
namesArr = np.array(['q_p','dx_dz','dy_dz','x','y'])
xAxisArr = []
xAxisNum = []

for var in enumerate(maxcompArr):
    xAxisArr.append(str(var[1]))
    xAxisNum.append(var[0])

for name in enumerate(namesArr):
#    img_name = 'q/p_.jpg'
    #scipy.misc.toimage(y, cmin=0.0, cmax=28.0).save(img_name)
    plt.figure(name[0])
    plt.xlabel('maxcomp')
    plt.ylabel(name[1])
    plt.xticks(xAxisNum, xAxisArr)
    plt.plot(stabw_mean[xAxisNum,name[0]], label='mean')
    plt.plot(stabw_mode[xAxisNum,name[0]], label='mode')
    plt.plot(stabw_medi[xAxisNum,name[0]], label='medi')
    plt.plot(stabw_base[xAxisNum,name[0]], label='base')
#    plt.show()
    plt.legend(loc='best')
    plt.savefig(workingdir + '/plots/stabw/' + name[1] + '.png')
    plt.gcf().clear()

    plt.figure(name[0])
    plt.xlabel('maxcomp')
    plt.ylabel(name[1])
    plt.xticks(xAxisNum, xAxisArr)
    plt.plot(meand_mean[xAxisNum,name[0]], label='mean')
    plt.plot(meand_mode[xAxisNum,name[0]], label='mode')
    plt.plot(meand_medi[xAxisNum,name[0]], label='medi')
    plt.plot(meand_base[xAxisNum,name[0]], label='base')
#    plt.show()
    plt.legend(loc='best')
    plt.savefig(workingdir + '/plots/meand/' + name[1] + '.png')
    plt.gcf().clear()

    plt.figure(name[0])
    plt.xlabel('maxcomp')
    plt.ylabel(name[1])
    plt.xticks(xAxisNum, xAxisArr)
    plt.plot(medid_mean[xAxisNum,name[0]], label='mean')
    plt.plot(medid_mode[xAxisNum,name[0]], label='mode')
    plt.plot(medid_medi[xAxisNum,name[0]], label='medi')
    plt.plot(medid_base[xAxisNum,name[0]], label='base')
#    plt.show()
    plt.legend(loc='best')
    plt.savefig(workingdir + '/plots/medid/' + name[1] + '.png')
    plt.gcf().clear()
