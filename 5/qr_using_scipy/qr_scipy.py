import pprint
import scipy
import scipy.linalg

A = scipy.array([[12, -51, 4], [6, 167, -68], [-4, 24, -41]])

Q, R = scipy.linalg.qr(A)

print ("A:")
pprint.pprint(A)

print ("Q:")
pprint.pprint(Q)

print ("R:")
pprint.pprint(R)