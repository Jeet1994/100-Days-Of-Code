import pprint

import numpy as np

a = np.matrix('12 -51 4; 6 167 -68; -4 24 -41')

q, r = np.linalg.qr(a)

print ("A:")
pprint.pprint(a)

print ("Q:")
pprint.pprint(q)

print ("R:")
pprint.pprint(r)

