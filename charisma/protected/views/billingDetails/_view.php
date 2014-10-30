<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('idinvoice')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idinvoice0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('idmedical')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idmedical0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('quantity')); ?>:
	<?php echo GxHtml::encode($data->quantity); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('price')); ?>:
	<?php echo GxHtml::encode($data->price); ?>
	<br />

</div>