<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('idinvoice')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idinvoice0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('iddrug')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->iddrug0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('quantity')); ?>:
	<?php echo GxHtml::encode($data->quantity); ?>
	<br />

</div>