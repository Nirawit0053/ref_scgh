function findTableerror(el) {
	for (const key in el) {
	if (key.startsWith('__reactInternalInstance$')) {
		const fiberNode = el[key];
		const pendingPropsC = fiberNode.pendingProps.children;
			for (const [key, value] of Object.entries(pendingPropsC)) {
				if(value.hasOwnProperty('props')) {
					const dprops = value.props;
					if(dprops.hasOwnProperty('classes')) {
						const dset = dprops.classes;
							const v = dset.tableCellError;
							return v;
						}
					}
				}
			}
	}
	return null;
};

var ele = document.getElementsByClassName('MuiTable-root')[0];
var tableValue = findTableerror(ele);
return tableValue;