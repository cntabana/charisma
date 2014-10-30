<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('medical_act')); ?>:
	<?php echo GxHtml::encode($data->medical_act); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('idservice')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idservice0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('type')); ?>:
	<?php echo GxHtml::encode($data->type); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('transfer')); ?>:
	<?php echo GxHtml::encode($data->transfer); ?>
	<br />

</div>