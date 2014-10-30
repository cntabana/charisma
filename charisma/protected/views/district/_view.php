<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('district')); ?>:
	<?php echo GxHtml::encode($data->district); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('idprovince')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idprovince0)); ?>
	<br />

</div>