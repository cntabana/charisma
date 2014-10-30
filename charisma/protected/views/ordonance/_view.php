<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('eye')); ?>:
	<?php echo GxHtml::encode($data->eye); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('type')); ?>:
	<?php echo GxHtml::encode($data->type); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('typeofglass')); ?>:
	<?php echo GxHtml::encode($data->typeofglass); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('vision')); ?>:
	<?php echo GxHtml::encode($data->vision); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('lunette')); ?>:
	<?php echo GxHtml::encode($data->lunette); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('interpupillarydistance')); ?>:
	<?php echo GxHtml::encode($data->interpupillarydistance); ?>
	<br />
	<?php /*
	<?php echo GxHtml::encode($data->getAttributeLabel('idinvoice')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idinvoice0)); ?>
	<br />
	*/ ?>

</div>