function findForcast(el) {
	for (const key in el) {
	if (key.startsWith('__reactInternalInstance$')) {
		const fiberNode = el[key];
		const pendingPropsC = fiberNode.pendingProps.children;
			for (const [key, value] of Object.entries(pendingPropsC)) {
				if(value.hasOwnProperty('props')) {
					const dprops = value.props;
					if(dprops.hasOwnProperty('data')) {
						const dset = dprops.data.datasets;
						for (const [key, value] of Object.entries(dset)) {
							if (value.label.includes('Forecast')) {
								// 0 is jan
								const v = value.data[0];
								return v;
							}
						}
					}
				}
			}
	}
	}
	return null;
};

var ele = document.getElementsByClassName("mb-8 pt-6")[0];
var forcastValue = findForcast(ele);
return forcastValue;